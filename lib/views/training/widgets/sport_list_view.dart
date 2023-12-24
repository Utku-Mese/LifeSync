import 'package:flutter/material.dart';
import 'package:life_sync/models/user_model.dart';
import 'sport_view.dart';

class SportListView extends StatefulWidget {
  const SportListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.user})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final User user;
  @override
  // ignore: library_private_types_in_public_api
  _SportListViewState createState() => _SportListViewState();
}

class _SportListViewState extends State<SportListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> sportListImages = [
    'assets/images/area1.png',
    'assets/images/area2.png',
    'assets/images/area3.png',
    'assets/images/area4.png',
  ];
  List<String> sportListNames = [
    'Box',
    'Yoga',
    'Koşu',
    'Kickbox',
  ];

  List<int> sportIndex = [
    6,
    0,
    5,
    6,
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
                  ),
                  children: List<Widget>.generate(
                    sportListImages.length,
                    (int index) {
                      final int count = sportListImages.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return SportView(
                        user: widget.user,
                        sportIndex: sportIndex[index],
                        name: sportListNames[index],
                        imagepath: sportListImages[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
