import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_model.dart';
import '../models/user_model.dart';

class DiaryController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addDiary(User user, Food food, String mealType) async {
    try {
      int newCalorie = user.calorie + (food.calories ?? 0);
      double newFat = user.fat + (food.fat ?? 0);
      double newProtein = user.protein + (food.protein ?? 0);
      double newCarbohydrate = user.carbohydrate + (food.carbohydrate ?? 0);

      await firestore.collection('users').doc(user.uid).update({
        'calorie': newCalorie,
        'fat': newFat,
        'protein': newProtein,
        'carbohydrate': newCarbohydrate,
        'lastMeal': Timestamp.now(),
      });

      await firestore.collection('users').doc(user.uid).update({
        '${mealType}_meal': FieldValue.arrayUnion([
          {
            'name': food.name,
            'calorie': food.calories,
            'fat': food.fat,
            'protein': food.protein,
            'carbohydrate': food.carbohydrate,
            'date': Timestamp.now(),
          }
        ])
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error adding to diary: $e");
      throw Exception('Could not add to diary.');
    }
  }

  Future<void> deleteDiary(User user, Food food, String mealType) async {
    try {
      int newCalorie = user.calorie - (food.calories ?? 0);
      double newFat = user.fat - (food.fat ?? 0);
      double newProtein = user.protein - (food.protein ?? 0);
      double newCarbohydrate = user.carbohydrate - (food.carbohydrate ?? 0);

      await firestore.collection('users').doc(user.uid).update({
        'calorie': newCalorie,
        'fat': newFat,
        'protein': newProtein,
        'carbohydrate': newCarbohydrate,
        'lastMeal': Timestamp.now(),
      });

      await firestore.collection('users').doc(user.uid).update({
        '${mealType}_meal': FieldValue.arrayRemove([
          {
            'name': food.name,
            'calorie': food.calories,
            'fat': food.fat,
            'protein': food.protein,
            'carbohydrate': food.carbohydrate,
            'date': Timestamp.now(),
          }
        ])
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error deleting from diary: $e");
      throw Exception('Could not delete from diary.');
    }
  }

  Future<void> updateDiary(User user, Food food, String mealType) async {
    try {
      int newCalorie = user.calorie - (food.calories ?? 0);
      double newFat = user.fat - (food.fat ?? 0);
      double newProtein = user.protein - (food.protein ?? 0);
      double newCarbohydrate = user.carbohydrate - (food.carbohydrate ?? 0);

      await firestore.collection('users').doc(user.uid).update({
        'calorie': newCalorie,
        'fat': newFat,
        'protein': newProtein,
        'carbohydrate': newCarbohydrate,
        'lastMeal': Timestamp.now(),
      });

      await firestore.collection('users').doc(user.uid).update({
        '${mealType}_meal': FieldValue.arrayRemove([
          {
            'name': food.name,
            'calorie': food.calories,
            'fat': food.fat,
            'protein': food.protein,
            'carbohydrate': food.carbohydrate,
            'date': Timestamp.now(),
          }
        ])
      });

      newCalorie = user.calorie + (food.calories ?? 0);
      newFat = user.fat + (food.fat ?? 0);
      newProtein = user.protein + (food.protein ?? 0);
      newCarbohydrate = user.carbohydrate + (food.carbohydrate ?? 0);

      await firestore.collection('users').doc(user.uid).update({
        'calorie': newCalorie,
        'fat': newFat,
        'protein': newProtein,
        'carbohydrate': newCarbohydrate,
        'lastMeal': Timestamp.now(),
      });

      await firestore.collection('users').doc(user.uid).update({
        '${mealType}_meal': FieldValue.arrayUnion([
          {
            'name': food.name,
            'calorie': food.calories,
            'fat': food.fat,
            'protein': food.protein,
            'carbohydrate': food.carbohydrate,
            'date': Timestamp.now(),
          }
        ])
      });
    } catch (e) {
      throw Exception('Could not update diary.');
    }
  }

  Future<int> getDiaryData(User user, String mealType) async {
    int calorie = 0;
    try {
      var documentSnapshot =
          await firestore.collection('users').doc(user.uid).get();
      if (documentSnapshot.exists) {
        var foods = documentSnapshot.data()?['${mealType}_meal'];
        for (var item in foods) {
          calorie += item['calorie'] as int;
        }
        return calorie;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}




/* class DiaryController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addFood(User user, Food food) async {
    try {

      int newCalorie = user.calorie + (food.calories ?? 0);
      double newFat = user.fat + (food.fat ?? 0);
      double newProtein = user.protein + (food.protein ?? 0);
      double newCarbohydrate = user.carbohydrate + (food.carbohydrate ?? 0);

      /* await firestore.collection('users').doc(user.uid).collection('diary').add({
        'name': food.name,
        'calorie': food.calories,
        'fat': food.fat,
        'protein': food.protein,
        'carbohydrate': food.carbohydrate,
        'date': Timestamp.now(),
      }); */

      await firestore.collection('users').doc(user.uid).update({
        'calorie': newCalorie,
        'fat': newFat,
        'protein': newProtein,
        'carbohydrate': newCarbohydrate,
        'lastMeal': Timestamp.now(),
      });
    } catch (e) {
      // Handle error
      print("Error adding to diary: $e");
      throw Exception('Could not add to diary.');
    }
  }
} */
