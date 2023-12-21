import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_sync/models/user_model.dart' as Umodel;
import '../utils/constants.dart';

class AuthController {
  String downloadUrl =
      "https://cdn-icons-png.flaticon.com/512/847/847969.png?w=740&t=st=1690124807~exp=1690125407~hmac=62e162d8114cb9b66801673f94a7abfbf3a0f38a28d78caea82d5e1c9d89d529";

  late Umodel.User user;

  User? get userAuth => firebaseAuth.currentUser;
  File? get image => _pickedImage;

  late File? _pickedImage;

  void pickImage() async {
    final picedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picedImage != null) {
      _pickedImage = File(picedImage.path);
    } else {
      _pickedImage = File("assets/images/profilePicture.png");
    }
  }

  Future<String> _uploadToStorage(File? image) async {
    var ref = firebaseStorage.ref().child(
        'profilePhotos/${userAuth!.uid}'); // or .child('profilePhotos/${firebaseAuth.currentUser!.uid}');
    var uploadTask = ref.putFile(image!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    return downloadUrl;
  }

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

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String username,
    required File? profilePhoto,
    required int height,
    required double weight,
    required DateTime birdDate,
    required String gender,
  }) async {
    try {
      if (name.isNotEmpty &&
          surname.isNotEmpty &&
          username.isNotEmpty &&
          gender.isNotEmpty &&
          profilePhoto != null) {
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        downloadUrl = await _uploadToStorage(profilePhoto);
        Umodel.User user = Umodel.User(
          name: name,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
          surname: surname,
          username: username,
          height: height,
          weight: weight,
          birdDate: birdDate,
          gender: gender,
        );
        firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      } else {
        /* ShowSnackBar.showSnackBar('Lütfen tüm alanları doldurunuz!'); */
        throw Exception('Lütfen tüm alanları doldurunuz!');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      /* ShowSnackBar.showSnackBar(e.message!); */
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
