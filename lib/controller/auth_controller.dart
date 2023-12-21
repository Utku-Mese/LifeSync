import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:life_sync/models/user_model.dart' as Umodel;
import '../utils/constants.dart';

class AuthController {
  String downloadUrl =
      "https://cdn-icons-png.flaticon.com/512/847/847969.png?w=740&t=st=1690124807~exp=1690125407~hmac=62e162d8114cb9b66801673f94a7abfbf3a0f38a28d78caea82d5e1c9d89d529";

  late Umodel.User user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get userAuth => firebaseAuth.currentUser;
  File? get image => _pickedImage;

  late File? _pickedImage;

  Future<Umodel.User?> getCurrentUser() async {
    User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      // Firestore'dan kullanıcı bilgilerini çekme
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (userSnapshot.exists) {
        // Firestore'dan gelen veriyi kullanıcı modelinize dönüştürme
        Umodel.User user = Umodel.User.fromSnap(userSnapshot);

        return user;
      }
    }

    return null;
  }

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
    var ref = firebaseStorage.ref().child('profilePhotos/${userAuth!.uid}');
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
        // Firebase Auth işlemleri
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Storage'a profil fotoğrafını yükle
        downloadUrl = await _uploadToStorage(profilePhoto);

        // Firestore'a kullanıcı bilgilerini ekleyin
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

        // Firestore'a kullanıcı bilgilerini ekleyin
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        throw Exception('Lütfen tüm alanları doldurunuz!');
      }
    } catch (e) {
      // Hata yönetimi
      debugPrint(e.toString());
      throw Exception('Bir hata oluştu!');
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
