import 'package:flutter/material.dart';
import 'package:life_sync/controller/auth_controller.dart';
import 'package:life_sync/views/authentication/login_screen.dart';
import 'package:life_sync/views/authentication/widgets/my_text_field.dart';

import 'widgets/social_auth_card.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
AuthController authController = AuthController();

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/signup.png',
              height: 200.0,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Aramıza katılın',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: MyTextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                emailController: emailController,
                text: 'Email',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: MyTextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                emailController: passwordController,
                text: 'Şifre',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: MyTextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                emailController: confirmPasswordController,
                text: 'Şifre Tekrar',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    authController.createUserWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hata'),
                        content: const Text('Şifreler eşleşmiyor!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tamam'))
                        ],
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                  ),
                ),
                child: const Text(
                  'Kayıt Ol',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Divider(
                    indent: 16.0,
                    endIndent: 16.0,
                    thickness: 1.0,
                  ),
                ),
                const Text('veya'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Divider(
                    indent: 16.0,
                    endIndent: 16.0,
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialAuthCard(
                    imagePath: 'assets/images/google.png',
                    onPressed: authController.signInWithGoogle,
                  ),
                  const SizedBox(width: 24.0),
                  const SocialAuthCard(
                    imagePath: 'assets/images/facebook.png',
                    onPressed: null,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Zaten bir hesabın var mı?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Giriş yap'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
