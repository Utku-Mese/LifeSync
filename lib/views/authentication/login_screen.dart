import 'package:flutter/material.dart';
import 'package:life_sync/views/authentication/signup_screen.dart';
import 'package:life_sync/views/home_screen.dart';

import 'widgets/my_text_field.dart';
import 'widgets/social_auth_card.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 32.0),
            child: Image.asset('assets/images/login.png', height: 200.0),
          ),
          /* const Padding(
            padding: EdgeInsets.only(bottom: 12.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hesabınıza giriş yapın',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ), */
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyTextField(
              emailController: emailController,
              text: 'Email',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyTextField(
              emailController: passwordController,
              text: 'Şifre',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                ),
              ),
              child: const Text(
                'Giriş Yap',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(
            indent: 16.0,
            endIndent: 16.0,
            thickness: 1.0,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialAuthCard(imagePath: 'assets/images/google.png'),
                SizedBox(width: 24.0),
                SocialAuthCard(imagePath: 'assets/images/facebook.png'),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hala hesabın yok mu?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text('Kayıt ol'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
