import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class SportView extends StatelessWidget {
  const SportView({
    Key? key,
    this.imagepath,
    this.name = "",
    this.animationController,
    this.animation,
  }) : super(key: key);

  final String name;
  final String? imagepath;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.27,
                          color: AppTheme.darkerText,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: SizedBox(
                          height: 150,
                          child: Image.asset(imagepath!),
                        ),
                      ),
                    ],
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
