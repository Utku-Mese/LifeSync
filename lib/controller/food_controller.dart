//xx
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodController {
  List<Food> parseFoods(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => Food.fromJson(json)).toList();
  }

  Future<List<Food>> fetchFoods() async {
    final response =
        await http.get(Uri.parse('http://192.168.252.229:8000/foods'));

    if (response.statusCode == 200) {
      final foods = parseFoods(response.body);
      return foods;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }
  

  Future<List<Food>> fetchFoodsByType(String type) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.34:8000/api/foods/$type')); //! ToDo: /api rootlari kaldirilmali

    if (response.statusCode == 200) {
      final foods = parseFoods(response.body);
      final foodByType = foods.where((food) => food.type == type).toList();
      return foodByType;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<Food> createFood(Food food) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.34:8000/api/foods'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          food.toJson()), // Food nesnesini JSON formatına çeviriyoruz
    );

    if (response.statusCode == 201) {
      // API tarafından oluşturulan Food nesnesi döndürlebilir
      return Food.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  getCalories(Food food, double porsiyon) {
    int calories = food.calories ?? 0;
    return calories * (porsiyon / 100);
  }
}
