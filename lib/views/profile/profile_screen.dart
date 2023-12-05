import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../widgets/title_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
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
    const int count = 5;

    listViews.add(
      Container(
        margin: const EdgeInsets.all(50.0),
        height: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.nearlyBlue.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 40.0,
              spreadRadius: 20.0,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(25.0),
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.nearlyDarkBlue.withOpacity(0.5),
                offset: const Offset(1, 1),
                blurRadius: 30.0,
                spreadRadius: 10.0,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
    listViews.add(
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: AppTheme.nearlyDarkBlue.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: const Text(
            'Kullanıcı Adı',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              color: AppTheme.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
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
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
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
          );
        }
      },
    );
  }
}
