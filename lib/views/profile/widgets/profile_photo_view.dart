import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class ProfilePhotoView extends StatelessWidget {
  const ProfilePhotoView({
    super.key,
    this.animationController,
  });

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.nearlyDarkBlue.withOpacity(0.5),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.grey.withOpacity(0.5),
              offset: const Offset(4.0, 4.0),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        width: 90,
        height: 90,
        margin: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: ClipOval(
            child: Image.network(
                'https://avatars.githubusercontent.com/u/94257756?v=4'),
          ),
        ),
      ),
    );
  }
}
