import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:life_sync/views/authentication/form_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:life_sync/views/authentication/login_screen.dart';
import 'services/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      /* scaffoldMessengerKey:
          ShowSnackBar.messengerKey, // for error messages in auth */
      debugShowCheckedModeBanner: false,
      title: 'Life Sync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.nearlyDarkBlue),
        textTheme: AppTheme.textTheme,
        useMaterial3: false,
      ),
      home: const LoginScreen(),
    );
  }
}
