import 'package:flutter/material.dart';
import 'package:life_sync/controller/auth_controller.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:life_sync/views/diary/diary_screen.dart';
import 'package:life_sync/views/newsAndRecipes/journal_screen.dart';
import 'package:life_sync/views/profile/profile_screen.dart';

import '../utils/tab_icon_data.dart';
import 'training/training_screen.dart';
import 'widgets/bottom_bar_view.dart';
// ignore: library_prefixes
import '../models/user_model.dart' as Umodel;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  AuthController authController = AuthController();

  Widget? tabBody;
  /* Container(
    color: AppTheme.background,
  ); */

  @override
  void initState() {
    getData();
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    /* tabBody = DiaryScreen(
      animationController: animationController,
      user: Umodel.User.getUserData(authController.userAuth!.uid),
    ); */
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: WillPopScope(
        onWillPop: () => Future<bool>.value(false),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody!,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  /* Future<bool> getData() async {
    //await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (tabBody == null) {
      tabBody = DiaryScreen(
        animationController: animationController,
        user: await Umodel.User.getUserData(authController.userAuth!.uid),
      );
      return true;
    }
    return true;
  } */

  Future<bool>? _getDataFuture;

  Future<bool> getData() async {
    _getDataFuture ??=
        Umodel.User.getUserData(authController.userAuth!.uid).then((user) {
      tabBody = DiaryScreen(
        animationController: animationController,
        user: user,
      );
      return true;
    }).catchError((error) {
      print('Hata: $error');
      return false;
    });
    return _getDataFuture!;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) async {
            Umodel.User? currentUser = authController.userAuth != null
                ? await Umodel.User.getUserData(authController.userAuth!.uid)
                : null;
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DiaryScreen(
                    animationController: animationController,
                    user: currentUser!, //FirebaseAuth.instance.currentUser!,
                  );
                });
              });
            } else if (index == 1) {
              Umodel.User? currentUser = authController.userAuth != null
                  ? await Umodel.User.getUserData(authController.userAuth!.uid)
                  : null;
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = TrainingScreen(
                    animationController: animationController,
                    user: currentUser!,
                  );
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const JournalScreen();
                });
              });
            } else if (index == 3) {
              Umodel.User? currentUser = authController.userAuth != null
                  ? await Umodel.User.getUserData(authController.userAuth!.uid)
                  : null;
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(
                    animationController: animationController,
                    user: currentUser!,
                  );
                });
              });
            }
          },
        ),
      ],
    );
  }
}
