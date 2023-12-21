import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constants.dart';

class User {
  String name;
  String surname;
  String username;
  String email;
  String profilePhoto;
  String uid;
  int height;
  double weight;
  DateTime birdDate;
  String gender;
  int calorie;
  double fat;
  double protein;
  double carbohydrate;
  int water;

  User({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
    required this.surname,
    required this.username,
    required this.height,
    required this.weight,
    required this.birdDate,
    required this.gender,
    required this.calorie,
    required this.fat,
    required this.protein,
    required this.carbohydrate,
    required this.water,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "surname": surname,
        "username": username,
        "height": height,
        "weight": weight,
        "gender": gender,
        "birdDate": birdDate,
        "calorie": calorie,
        "fat": fat,
        "protein": protein,
        "carbohydrate": carbohydrate,
        "water": water,
      };

  static Future<User?> getUserData(String uid) async {
    try {
      var snapshot = await firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return fromSnap(snapshot);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Firestore veri çekme hatası: $e");
      return null;
    }
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      surname: snapshot['surname'],
      username: snapshot['username'],
      height: snapshot['height'],
      weight: snapshot['weight'],
      birdDate: DateTime.parse(snapshot['birdDate'].toDate().toString()),
      gender: snapshot['gender'],
      calorie: snapshot['calorie'],
      fat: snapshot['fat'],
      protein: snapshot['protein'],
      carbohydrate: snapshot['carbohydrate'],
      water: snapshot['water'],
    );
  }
}
