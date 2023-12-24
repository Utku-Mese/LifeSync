import 'package:flutter/material.dart';
import 'package:life_sync/utils/tasks_data.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_theme.dart';

class TaskView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  final User user;

  const TaskView(
      {Key? key, this.animationController, this.animation, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    const Text(
                      "Günlük hedefler",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.27,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const Text(
                      "0/4",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        letterSpacing: 0.27,
                        color: AppTheme.nearlyDarkBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 24),
                      child: ListView.builder(
                        itemCount: Task.tasks.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              Task.tasks[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.1,
                                color: AppTheme.darkText,
                              ),
                            ),
                            subtitle: Text(
                              Task.tasks[index].goal,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                            trailing: index == 2
                                ? user.water >= 3500
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: AppTheme.nearlyDarkBlue,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline,
                                        color: AppTheme.nearlyDarkBlue,
                                        size: 30,
                                      )
                                : index == 1
                                    ? user.burnedCalorie >= 250
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppTheme.nearlyDarkBlue,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.check_circle_outline,
                                            color: AppTheme.nearlyDarkBlue,
                                            size: 30,
                                          )
                                    : Task.tasks[index].isCompleted
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AppTheme.nearlyDarkBlue,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.check_circle_outline,
                                            color: AppTheme.nearlyDarkBlue,
                                            size: 30,
                                          ),
                            /* trailing: Task.tasks[index].isCompleted
                                ? Image.asset(
                                    "assets/images/check.png",
                                    width: 30,
                                  )
                                : null, */
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
