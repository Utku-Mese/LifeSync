import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/controller/diary_controller.dart';
import 'package:life_sync/controller/sport_controller.dart';
import 'package:life_sync/models/sport_model.dart';
import 'package:life_sync/models/user_model.dart';

import '../../../utils/app_theme.dart';

class SportView extends StatefulWidget {
  const SportView({
    Key? key,
    this.imagepath,
    this.name = "",
    this.animationController,
    this.animation,
    required this.sportIndex,
    required this.user,
  }) : super(key: key);

  final String name;
  final String? imagepath;
  final int sportIndex;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final User user;

  @override
  State<SportView> createState() => _SportViewState();
}

SportController sportController = SportController();
DiaryController diaryController = DiaryController();
TextEditingController _timeController = TextEditingController();

class _SportViewState extends State<SportView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
            child: FutureBuilder<List<Sport>>(
              future: sportController.fetchSports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Could not retrieve data: ${snapshot.error}'),
                  );
                } else {
                  final sports = snapshot.data;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.grey.withOpacity(0.4),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Spor Bilgileri',
                            body: Column(
                              children: [
                                Text(
                                  'Spor Adı: ${sports![widget.sportIndex].name}\n'
                                  'Spor Türü: kardio\n'
                                  'Kalori: ${sports[widget.sportIndex].calories}/h\n',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    wordSpacing: 2,
                                    letterSpacing: 1,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: TextField(
                                    controller: _timeController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Süre(dk)',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              diaryController.addBurnedCalorie(
                                widget.user,
                                (sports[widget.sportIndex].calories! *
                                        int.parse(_timeController.text)) ~/
                                    60,
                              );
                              _timeController.clear();
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Spor Eklendi',
                                desc: 'Spor başarıyla eklendi.',
                                btnOkOnPress: () {},
                              ).show();
                            },
                          ).show();
                        },
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.name,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.27,
                                color: AppTheme.darkerText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16),
                              child: Image.asset(
                                widget.imagepath!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
