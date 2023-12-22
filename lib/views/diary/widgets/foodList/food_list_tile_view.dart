import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/controller/diary_controller.dart';

import '../../../../models/food_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/app_theme.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.foods,
    required this.index,
    required this.user,
    required this.mealType,
  });

  final User user;
  final List<Food>? foods;
  final int index;
  final String mealType;

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
    DiaryController diaryController = DiaryController();

    return SizedBox(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
        child: ListTile(
          shape: ShapeBorder.lerp(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(30),
              ),
            ),
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
                top: Radius.circular(30),
              ),
            ),
            1,
          ),
          tileColor: AppTheme.darkGrey.withOpacity(0.07),
          onTap: () {
            //_showDialog(context);
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.info,
              body: Center(
                child: Column(
                  children: [
                    const Text(
                      'Emin misiniz?',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kalori: ${foods![index].calories} kcal \nYağ: ${foods![index].fat} g \nProtein: ${foods![index].protein} g \nKarbonhidrat: ${foods![index].carbohydrate} g',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              btnOkOnPress: () {
                diaryController.addDiary(
                    user, foods![index], mealType); // Adding food to diary
                Navigator.pop(context);
              },
              btnOkColor: Colors.green,
              btnOkText: 'Evet',
              btnCancelColor: Colors.red,
              btnCancelOnPress: () {},
              btnCancelText: 'İptal',
              headerAnimationLoop: false,
            ).show();
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
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(foods![index].name!,
                style: AppTheme.title.copyWith(fontFamily: AppTheme.fontName),
                overflow: TextOverflow.ellipsis),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foods![index].type!,
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  height: 10,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 72,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${foods![index].protein!}g',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.nearlyWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            ' Protein',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 72,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${foods![index].fat!}g',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.nearlyWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            ' Yağ',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 72,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyDarkBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${foods![index].carbohydrate!}g',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppTheme.nearlyWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            ' Karbonhidrat',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          trailing: const Icon(Icons.add, color: AppTheme.nearlyDarkBlue),
        ),
      ),
    );
  }
}
