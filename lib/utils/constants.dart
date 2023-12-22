import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_share/flutter_share.dart';

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// FUNCTIONS
int daysBetween(DateTime from) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day)
      .difference(DateTime(from.year, from.month, from.day))
      .inDays;
}

Future<void> share(String title, String text, String url) async {
  await FlutterShare.share(
    title: title,
    text: text,
    linkUrl: url,
  );
}


