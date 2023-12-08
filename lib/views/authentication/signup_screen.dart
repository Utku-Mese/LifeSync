import 'package:flutter/material.dart';
import 'package:life_sync/views/authentication/login_screen.dart';
import 'package:life_sync/views/authentication/widgets/my_text_field.dart';

import 'widgets/social_auth_card.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 54.0),
              child: Text(
                'Aramıza katılın',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
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
              child: MyTextField(
                emailController: confirmPasswordController,
                text: 'Şifre Tekrar',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
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
            const Divider(
              indent: 16.0,
              endIndent: 16.0,
              thickness: 1.0,
              height: 50.0,
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
