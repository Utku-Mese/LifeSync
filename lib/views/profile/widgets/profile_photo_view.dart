import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';

class ProfilePhotoView extends StatelessWidget {
  const ProfilePhotoView({
    Key? key,
    this.animationController,
    required this.imagePath,
  }) : super(key: key);

  final AnimationController? animationController;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: CurvedAnimation(
        parent: animationController!,
        curve: Curves.fastOutSlowIn,
      ),
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
            child: FutureBuilder<Image>(
              future: loadImage(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Hata oluştu: ${snapshot.error}'),
                  );
                } else {
                  return snapshot.data!;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Image> loadImage(BuildContext context) async {
    // Asenkron olarak resmi yükle
    Image image = Image.network(
      imagePath,
      fit: BoxFit.cover,
      width: 90,
      height: 90,
    );

    // Resmin yüklenip yüklenmediğini bekleyerek kontrol et
    await precacheImage(image.image, context);
    return image;
  }
}
