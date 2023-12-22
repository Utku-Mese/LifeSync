import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:life_sync/models/recipe_model.dart';

class RecipeController {
  List<Recipe> parseRecipe(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  }

  //Get_all
  Future<List<Recipe>> fetchRecipes() async {
    final response =await http.get(Uri.parse('http://192.168.1.36:8000/recipes'));
    if (response.statusCode == 200) {
      final recipes = parseRecipe(response.body);
      // ignore: avoid_print
      print(response.body);
      return recipes;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<List<Recipe>> fetchRecipesByDate() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.34:8000/recipe/date'));

      if (response.statusCode == 200) {
        final recipes = parseRecipe(response.body);
        return recipes;
      } else {
        throw Exception('API request failed: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
