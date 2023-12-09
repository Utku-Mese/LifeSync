import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Bu email adresi ile bir kullanıcı bulunamadı!');
      } else if (e.code == 'wrong-password') {
        throw Exception('Yanlış şifre girdiniz!');
      } else {
        throw Exception('Bir hata oluştu!');
      }
    }
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      /* ShowSnackBar.showSnackBar(e.message!); */
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
