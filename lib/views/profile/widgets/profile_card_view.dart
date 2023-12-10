import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/views/profile/widgets/profile_photo_view.dart';

import '../../../utils/app_theme.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView(
      {super.key, this.animationController, required this.user});

  final AnimationController? animationController;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
      child: Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(24.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: AppTheme.nearlyDarkBlue.withOpacity(0.5),
              offset: const Offset(4.0, 4.0),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
          child: Row(
            children: [
              ProfilePhotoView(
                imagePath: user.photoURL ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png',
                animationController: animationController!,
              ),
              const SizedBox(width: 16.0),
              Column(
                children: [
                  Text(
                    user.displayName ?? user.email!,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
