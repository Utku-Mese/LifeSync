import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class SocialAuthCard extends StatelessWidget {
  const SocialAuthCard({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  final String imagePath;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed as void Function()?,
        icon: Image.asset(imagePath, height: 30.0),
        splashRadius: 30,
      ),
    );
  }
}
