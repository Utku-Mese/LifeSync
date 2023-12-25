import 'package:flutter/material.dart';
import 'package:life_sync/views/diary/widgets/task_view.dart';
import '../../utils/app_theme.dart';
import '../widgets/title_view.dart';
import 'widgets/body_measurement_view.dart';
import 'widgets/diet_view.dart';
import 'widgets/info_view.dart';
import 'widgets/meals_list_view.dart';
import 'widgets/water_view.dart';
// ignore: library_prefixes
import '../../models/user_model.dart' as Umodel;

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key, this.animationController, required this.user})
      : super(key: key);

  final AnimationController? animationController;
  final Umodel.User? user;
  @override
  // ignore: library_private_types_in_public_api
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController ??
                AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 600)),
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
    const int count = 9;

    listViews.add(
      TitleView(
          user: widget.user!,
          titleTxt: 'Besin Değerleri',
          subTxt: 'Detaylar',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 0, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );
    listViews.add(
      DietView(
          user: widget.user!,
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 1, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );
    listViews.add(
      TitleView(
          user: widget.user!,
          titleTxt: 'Öğünler',
          subTxt: 'Detaylar',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 2, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      MealsListView(
          user: widget.user!,
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 3, 1.0,
                      curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      TitleView(
          user: widget.user!,
          titleTxt: 'Su',
          subTxt: 'Detaylar',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 6, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      WaterView(
          user: widget.user!,
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 7, 1.0,
                      curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      InfoView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController ??
                AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 600)),
            curve: const Interval((1 / count) * 8, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController ??
            AnimationController(
                vsync: this, duration: const Duration(milliseconds: 600)),
      ),
    );

    listViews.add(
      TitleView(
          user: widget.user!,
          titleTxt: 'Vücut Ölçüleri',
          subTxt: 'Düzenle',
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 4, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      BodyMeasurementView(
          user: widget.user!,
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 5, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      TitleView(
          user: widget.user!,
          titleTxt: "Görevler",
          subTxt: "Tümünü Gör",
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 4, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(
      TaskView(
          user: widget.user!,
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 600)),
                  curve: const Interval((1 / count) * 5, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600))),
    );

    listViews.add(const SizedBox(height: 8));
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
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
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
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                listViews = <Widget>[];
                addAllListData();
              });

              _scaffoldKey.currentState?.dispose();
              _scaffoldKey = GlobalKey<ScaffoldState>();
            },
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: listViews.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                widget.animationController?.forward();
                return listViews[index];
              },
            ),
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController ??
              AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 600)),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'İyi Günler',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: const Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: AppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: AppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  Text(
                                    '25 Aralık',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      letterSpacing: -0.2,
                                      color: AppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: const Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppTheme.grey,
                                  ),
                                ),
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
}
