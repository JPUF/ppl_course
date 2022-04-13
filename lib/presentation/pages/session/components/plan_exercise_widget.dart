import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class PlanExerciseWidget extends StatefulWidget {
  const PlanExerciseWidget(
      {Key? key, required this.exercise, required this.sessionType})
      : super(key: key);

  final Exercise exercise;
  final SessionType sessionType;

  @override
  State<PlanExerciseWidget> createState() => _PlanExerciseWidgetState();
}

class _PlanExerciseWidgetState extends State<PlanExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor
                .getPplColor(widget.sessionType)
                .shade50,
            border: Border.all(
                color: AppColor.getPplColor(widget.sessionType), width: 1),
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Text(widget.exercise.name,
                        style: AppTextStyles.headline4.apply(
                            color: AppColor.getPplColor(widget.sessionType)))),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      buildWeight(),
                      const SizedBox(height: 8),
                      buildSetReps()
                    ],
                  ),
                ),
              ],
            ),
            buildExerciseNotes()
          ],
        ),
      ),
    );
  }

  Widget buildWeight() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/ic_generic_weight.svg',
          width: 12,
          height: 12,
        ),
        const SizedBox(width: 6),
        Text(widget.exercise.weight?.toString() ?? 'N/A',
            style: AppTextStyles.button
                .apply(color: AppColor.getPplColor(widget.sessionType))),
      ],
    );
  }

  Widget buildSetReps() {
    return Row(
      children: [
        const Icon(
          Icons.repeat,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(widget.exercise.setsReps.toString(),
            style: AppTextStyles.button
                .apply(color: AppColor.getPplColor(widget.sessionType))),
      ],
    );
  }

  Widget buildExerciseNotes() {
    final notes = widget.exercise.notes;
    if (notes != null) {
      return Column(children: [
        const Divider(height: 8),
        const SizedBox(height: 12),
        Text(notes, style: AppTextStyles.body12)
      ]);
    } else {
      return Container();
    }
  }
}
