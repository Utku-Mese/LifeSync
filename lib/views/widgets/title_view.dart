import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:life_sync/controller/sport_controller.dart';

import '../../controller/diary_controller.dart';
import '../../models/sport_model.dart';
import '../../models/user_model.dart';
import '../../utils/app_theme.dart';

class TitleView extends StatefulWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSportView;
  final int sportIndex;
  final User user;

  const TitleView({
    Key? key,
    this.titleTxt = "",
    this.subTxt = "",
    this.animationController,
    this.animation,
    this.isSportView = false,
    this.sportIndex = 0,
    required this.user,
  }) : super(key: key);

  @override
  State<TitleView> createState() => _TitleViewState();
}

SportController sportController = SportController();
DiaryController diaryController = DiaryController();
TextEditingController _timeController = TextEditingController();

class _TitleViewState extends State<TitleView> {
  @override
  Widget build(BuildContext context) {
    SportController sportController = SportController();
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: widget.isSportView
                ? FutureBuilder<List<Sport>>(
                    future: sportController.fetchSports(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                              'Could not retrieve data: ${snapshot.error}'),
                        );
                      } else {
                        final sports = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.titleTxt,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    color: AppTheme.lightText,
                                  ),
                                ),
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.NO_HEADER,
                                    animType: AnimType.BOTTOMSLIDE,
                                    btnCancel: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('İptal'),
                                    ),
                                    body: Column(
                                      children: [
                                        const Text(
                                          'Sporunu seç',
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                            color: AppTheme.lightText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 300,
                                          child: ListView.builder(
                                            itemCount: sports!.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(sports[index]
                                                    .name
                                                    .toString()),
                                                onTap: () {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType: DialogType.INFO,
                                                    animType:
                                                        AnimType.BOTTOMSLIDE,
                                                    title: 'Spor Bilgileri',
                                                    body: Column(
                                                      children: [
                                                        Text(
                                                          'Spor Adı: ${sports[index].name}\n'
                                                          'Spor Türü: kardio\n'
                                                          'Kalori: ${sports[index].calories}/h\n',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            wordSpacing: 2,
                                                            letterSpacing: 1,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                          child: TextField(
                                                            controller:
                                                                _timeController,
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Süre(dk)',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () {
                                                      diaryController
                                                          .addBurnedCalorie(
                                                        widget.user,
                                                        (sports[index]
                                                                    .calories! *
                                                                int.parse(
                                                                    _timeController
                                                                        .text)) ~/
                                                            60,
                                                      );
                                                      _timeController.clear();
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.SUCCES,
                                                        animType: AnimType
                                                            .BOTTOMSLIDE,
                                                        title: 'Spor Eklendi',
                                                        desc:
                                                            'Spor başarıyla eklendi.',
                                                        btnOkOnPress: () {},
                                                      ).show();
                                                    },
                                                  ).show();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).show();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        widget.subTxt,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                          color: AppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 38,
                                        width: 26,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: AppTheme.darkText,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.titleTxt,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: AppTheme.lightText,
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  widget.subTxt,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    color: AppTheme.nearlyDarkBlue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: AppTheme.darkText,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
