import 'package:flutter/material.dart';

import '../../../../models/food_model.dart';
import '../../../../utils/app_theme.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.foods,
    required this.index,
  });

  final List<Food>? foods;
  final int index;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text('Yiyecek eklendi')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color _getCaloriesColor(int calories) {
    if (calories < 50) {
      return Colors.green.shade300;
    } else if (calories < 70) {
      return Colors.green.shade500;
    } else if (calories < 100) {
      return Colors.green.shade700;
    } else if (calories < 120) {
      return Colors.orange.shade300;
    } else if (calories < 150) {
      return Colors.orange.shade500;
    } else if (calories < 200) {
      return Colors.orange.shade700;
    } else if (calories < 250) {
      return Colors.red.shade400;
    } else if (calories < 300) {
      return Colors.red.shade500;
    } else if (calories < 350) {
      return Colors.red.shade700;
    } else {
      return Colors.red.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _showDialog(context);
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: _getCaloriesColor(foods![index].calories!),
        child: Text(
          '${foods![index].calories!} \nkcal',
          style: const TextStyle(fontSize: 15, color: AppTheme.nearlyWhite),
          textAlign: TextAlign.center,
        ),
      ),
      title: Text(foods![index].name!, style: AppTheme.title.copyWith(fontFamily: AppTheme.fontName), overflow: TextOverflow.ellipsis),
      subtitle: Text(
        foods![index].type!,
        style: const TextStyle(fontSize: 15),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.add, color: AppTheme.nearlyDarkBlue),
    );
  }
}
