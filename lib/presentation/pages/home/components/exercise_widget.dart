import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget(
      {Key? key, required this.exercise, required this.sessionType})
      : super(key: key);

  final Exercise exercise;
  final SessionType sessionType;

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Text(widget.exercise.name,
                  style: AppTextStyles.body17
                      .apply(color: AppColor.getPplColor(widget.sessionType)))),
          const SizedBox(width: 16),
          Expanded(
              flex: 2,
              child: Text(widget.exercise.setsReps.toString(),
                  style: AppTextStyles.body14
                      .apply(color: AppColor.getPplColor(widget.sessionType)))),
          Expanded(
              flex: 2,
              child: Text(widget.exercise.weight?.toString() ?? 'N/A',
                  style: AppTextStyles.body14.apply(color: AppColor.getPplColor(widget.sessionType))))
        ],
      ),
    );
  }
}
