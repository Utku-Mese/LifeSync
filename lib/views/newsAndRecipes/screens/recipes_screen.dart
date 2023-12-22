import 'package:flutter/material.dart';
import 'package:life_sync/controller/recipe_controller.dart';
import 'package:life_sync/models/recipe_model.dart';
import 'package:life_sync/views/newsAndRecipes/widgets/card_loading_widget.dart';
import 'package:life_sync/views/newsAndRecipes/widgets/recipe_card.dart';
import '../../diary/widgets/foodList/my_search_bar_view.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final RecipeController _recipeController = RecipeController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySearchBar(),
        Expanded(
          child: FutureBuilder<List<Recipe>>(
            future: _recipeController.fetchRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const LoadingCard();
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Veriler getirilirken bir hata oluştu!: ${snapshot.error}'),
                );
              } else {
                final recipes = snapshot.data;
                return ListView.builder(
                  itemCount: recipes?.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(recipes: recipes, index: index);
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
