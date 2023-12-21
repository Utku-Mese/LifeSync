import 'package:cloud_firestore/cloud_firestore.dart';

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
      };

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
      birdDate: snapshot['birdDate'],
      gender: snapshot['gender'],
    );
  }
}
