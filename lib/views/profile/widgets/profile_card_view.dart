import 'package:flutter/material.dart';
import 'package:life_sync/views/profile/widgets/profile_photo_view.dart';

import '../../../utils/app_theme.dart';

class ProfileCardView extends StatelessWidget {
  ProfileCardView({super.key, this.animationController});

  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              animationController: animationController!,
            ),
            const SizedBox(width: 16.0),
            const Column(
              children: [
                Text(
                  'Mehmet Utku Meşe',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
