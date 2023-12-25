import 'package:flutter/material.dart';
import 'package:life_sync/controller/auth_controller.dart';
import 'package:life_sync/controller/body_measurement_controller.dart';
import 'package:life_sync/views/widgets/title_view.dart';

import '../../utils/app_theme.dart';
// ignore: library_prefixes
import '../../models/user_model.dart' as Umodel;
import 'widgets/profile_card_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.animationController,
    required this.user,
  });

  final Umodel.User user;
  final AnimationController? animationController;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  Animation<double>? animation;

  AuthController authController = AuthController();
  BodyMeasurementController bodyMeasurementController =
      BodyMeasurementController();

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval((1 / 4) * 3, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    listViews.add(
      ProfileCardView(
        animationController: widget.animationController,
        user: widget.user,
      ),
    );

    listViews.add(
      const SizedBox(
        height: 24,
      ),
    );

    listViews.add(
      const Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Divider(
          height: 1,
        ),
      ),
    );

    listViews.add(
      const SizedBox(
        height: 24,
      ),
    );
    listViews.add(
      TitleView(
        user: widget.user,
        titleTxt: 'Kupalarım',
        subTxt: 'Tümü',
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
      ),
    );
    listViews.add(
      const SizedBox(
        height: 24,
      ),
    );

    listViews.add(
      const Column(
        children: [
          Text(
            '🏆',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            '-',
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );

    listViews.add(
      TitleView(
        user: widget.user,
        titleTxt: 'Ölçümlerim',
        subTxt: 'Tümü',
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
      ),
    );

    listViews.add(
      AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      ListTile(
                        leading: const Icon(Icons.height),
                        title: const Text('Boy'),
                        subtitle: Text(
                          widget.user.height.toString(),
                        ),
                        trailing: const Icon(Icons.edit),
                      ),
                      ListTile(
                        leading: const Icon(Icons.monitor_weight_outlined),
                        title: const Text('Kilo'),
                        subtitle: Text(
                          widget.user.weight.toString(),
                        ),
                        trailing: const Icon(Icons.edit),
                      ),
                      ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: const Text(
                          'Vücut Kitle İndeksi',
                        ),
                        subtitle: Text(
                          bodyMeasurementController
                              .calculateBMI(
                                widget.user.weight,
                                widget.user.height,
                              )
                              .toStringAsFixed(2),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.water_drop),
                        title: const Text(
                          'Vücut Yağ Oranı',
                        ),
                        subtitle: Text(
                          bodyMeasurementController
                              .calculateBodyFatPercentage(
                                widget.user.weight,
                                widget.user.height,
                                bodyMeasurementController
                                    .calculateAge(widget.user.birdDate),
                                widget.user.gender == 'Erkek' ? true : false,
                              )
                              .toStringAsFixed(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    listViews.add(
      const SizedBox(
        height: 24,
      ),
    );

    listViews.add(
      TitleView(
        user: widget.user,
        titleTxt: 'Hedeflerim',
        subTxt: 'Tümü',
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
      ),
    );
    listViews.add(
      AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation!.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      const ListTile(
                        leading: Icon(Icons.run_circle_rounded),
                        title: Text('Adım Hedefi'),
                        subtitle: Text(
                          '10000',
                        ),
                        trailing: Icon(Icons.edit),
                      ),
                      ListTile(
                        leading: const Icon(Icons.fastfood),
                        title: const Text('Kalori Hedefi'),
                        subtitle: Text(
                          '${bodyMeasurementController.calculateCalorieNeeds(
                                age: bodyMeasurementController
                                    .calculateAge(widget.user.birdDate),
                                height: widget.user.height / 100,
                                weight: widget.user.weight,
                                isMale: widget.user.gender == 'Erkek'
                                    ? true
                                    : false,
                              ).toStringAsFixed(2)} kcal',
                        ),
                        trailing: const Icon(Icons.edit),
                      ),
                      const ListTile(
                        leading: Icon(Icons.water_drop),
                        title: Text(
                          'Su Hedefi',
                        ),
                        subtitle: Text('3500 ml'),
                        trailing: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    listViews.add(
      const SizedBox(
        height: 24,
      ),
    );

    listViews.add(
      TitleView(
        user: widget.user,
        titleTxt: 'Etkinliklerim',
        subTxt: 'Tümü',
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
      ),
    );

    listViews.add(
      const GridPaper(
        color: AppTheme.nearlyDarkBlue,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '🏃',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '🚴',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '🏋️',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ],
        ),
      ),
    );

    listViews.add(
      const SizedBox(
        height: 38,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '${widget.user.name} ${widget.user.surname}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0,
                  ),
                  BoxShadow(
                    color: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 20.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showPopupMenu(context);
              },
              icon: const Icon(
                Icons.more_horiz_sharp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            //getAppBarUI(),
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              /* top: AppBar().preferredSize.height + // Open for custom appbar
                  MediaQuery.of(context).padding.top + 
                  24, */
              top: 24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showPopupMenu(context);
                              },
                              icon: const Icon(
                                Icons.more_horiz_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          const Offset(400, 80),
          const Offset(440, 120),
        ),
        Offset.zero & MediaQuery.of(context).size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Profil Düzenle'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Çıkış Yap'),
            onTap: () {
              authController.signOut();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
