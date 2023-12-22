import 'package:flutter/material.dart';
import 'package:life_sync/controller/diary_controller.dart';

import '../../../models/user_model.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/hex_color.dart';
import '../../../utils/meals_list_data.dart';
import '../food_list_screen.dart';

class MealsView extends StatelessWidget {
  const MealsView({
    Key? key,
    this.mealsListData,
    this.animationController,
    this.animation,
    required this.mealType,
    required this.user,
  }) : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String mealType;
  final User user;

  @override
  Widget build(BuildContext context) {
    DiaryController diaryController = DiaryController();

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              100 * (1.0 - animation!.value),
              0.0,
              0.0,
            ),
            child: SizedBox(
              width: 160,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 8,
                      right: 8,
                      bottom: 16,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodListScreen(
                              mealType: mealType,
                              user: user,
                              animationController: animationController,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: HexColor(mealsListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor(mealsListData!.startColor),
                              HexColor(mealsListData!.endColor),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 54,
                            left: 16,
                            right: 16,
                            bottom: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                mealsListData!.titleTxt,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        mealsListData!.meals!.join('\n'),
                                        style: const TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          letterSpacing: 0.2,
                                          color: AppTheme.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FutureBuilder<int>(
                                future: diaryController.getDiaryData(
                                    user, mealType),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(
                                      color: AppTheme.white,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Hata: ${snapshot.error}');
                                  } else {
                                    int calorieResult = snapshot.data ?? 0;

                                    return snapshot.data == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.nearlyWhite,
                                              shape: BoxShape.circle,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: AppTheme.nearlyBlack
                                                        .withOpacity(0.4),
                                                    offset:
                                                        const Offset(8.0, 8.0),
                                                    blurRadius: 8.0),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Icon(
                                                Icons.add,
                                                color: HexColor(
                                                    mealsListData!.endColor),
                                                size: 24,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                calorieResult.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                  letterSpacing: 0.2,
                                                  color: AppTheme.white,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4, bottom: 3),
                                                child: Text(
                                                  'kcal',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    letterSpacing: 0.2,
                                                    color: AppTheme.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(mealsListData!.imagePath),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
