import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/models/food_model.dart';
import 'package:life_sync/models/user_model.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:life_sync/views/diary/widgets/foodList/my_search_bar_view.dart';
import '../../controller/food_controller.dart';
import 'widgets/foodList/food_list_tile_view.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({
    super.key,
    this.animationController,
    required this.user,
    required this.mealType,
  });
  final User user;
  final String mealType;
  final AnimationController? animationController;

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final FoodController _foodController = FoodController();

  late TextEditingController _searchController;
  late String _serchQuery;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _serchQuery = '';
  }

  Future<List<Food>> _searchFoods(String query) async {
    final allFoods = await _foodController.fetchFoods();

    if (query.isEmpty) {
      return allFoods;
    } else {
      final filteredFoods = allFoods
          .where(
              (food) => food.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return filteredFoods;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.nearlyDarkBlue,
        iconTheme: const IconThemeData(color: AppTheme.nearlyWhite),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
          ),
        ),
        /* shape: ShapeBorder.lerp(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(30),
              ),
            ),
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              ),
            ),
            1,
          ), */
        title: const Text(
          'Yiyecekler',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22 + 6 - 6,
            letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.filter_alt_rounded,
                color: AppTheme.nearlyWhite,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          MySearchBar(
            onSearchTextChanged: (query) {
              // Arama metni değiştikçe _searchFoods fonksiyonunu çağır
              setState(() {
                _serchQuery = query;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Food>>(
              future: _searchFoods(_serchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Could not retrieve data: ${snapshot.error}'),
                  );
                } else {
                  final foods = snapshot.data;
                  return ListView.builder(
                    itemCount: foods?.length,
                    itemBuilder: (context, index) {
                      return FoodListTile(
                        foods: foods,
                        index: index,
                        user: widget.user,
                        mealType: widget.mealType,
                      );
                    },
                    padding: const EdgeInsets.only(bottom: 20.0),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
