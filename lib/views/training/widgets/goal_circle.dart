import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../../../utils/hex_color.dart';
import '../../widgets/curve_painter.dart';

class GoalCircle extends StatelessWidget {
  const GoalCircle({
    super.key,
    required this.text,
    required this.value,
    required this.goal,
  });

  final String text;
  final int value;
  final int goal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  border: Border.all(
                      width: 4,
                      color: AppTheme.nearlyDarkBlue.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                        letterSpacing: 0.0,
                        color: AppTheme.nearlyDarkBlue,
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.0,
                        color: AppTheme.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomPaint(
                painter: CurvePainter(
                  angle: value < 1 ? 4.0 : value / goal * 350,
                  colors: [
                    AppTheme.nearlyDarkBlue,
                    HexColor("#8A98E8"),
                    HexColor("#8A98E8")
                  ],
                ),
                child: const SizedBox(
                  width: 108,
                  height: 108,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
