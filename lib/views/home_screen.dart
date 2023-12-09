import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:life_sync/views/diary/diary_screen.dart';
import 'package:life_sync/views/profile/profile_screen.dart';

import '../utils/tab_icon_data.dart';
import 'training/training_screen.dart';
import 'widgets/bottom_bar_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DiaryScreen(
      animationController: animationController,
      user: FirebaseAuth.instance.currentUser!,
    );
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
                    tabBody,
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

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
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
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DiaryScreen(
                    animationController: animationController,
                    user: FirebaseAuth.instance.currentUser!,
                  );
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController, user: FirebaseAuth.instance.currentUser!,);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const Center(
                    child: Text(
                        "Tarifler ve bülten üstten 2 tane tab  olucak wp gibi"),
                  );
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(
                    animationController: animationController,
                    user: FirebaseAuth.instance.currentUser!,
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
