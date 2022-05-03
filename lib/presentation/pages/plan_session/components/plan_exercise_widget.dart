import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
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
    final MaterialColor _pplColor = AppColor.getPplColor(widget.sessionType);
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
            color: _pplColor.shade50,
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 8,
                    child: Text(widget.exercise.name,
                        style: AppTextStyles.headline4.apply(
                            color: _pplColor))),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      buildWeight(_pplColor),
                      const SizedBox(height: 8),
                      buildSetReps(_pplColor)
                    ],
                  ),
                ),
              ],
            ),
            buildExerciseNotes(_pplColor)
          ],
        ),
      ),
    );
  }

  Widget buildWeight(MaterialColor pplColor) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/ic_generic_weight.svg',
          width: 12,
          height: 12,
          color: pplColor,
        ),
        const SizedBox(width: 6),
        Text(widget.exercise.weight?.toString() ?? 'N/A',
            style: AppTextStyles.button
                .apply(color: pplColor)),
      ],
    );
  }

  Widget buildSetReps(MaterialColor pplColor) {
    return Row(
      children: [
        Icon(
          Icons.repeat,
          size: 16,
          color: pplColor,
        ),
        const SizedBox(width: 4),
        Text(widget.exercise.setsReps.toString(),
            style: AppTextStyles.button
                .apply(color: pplColor)),
      ],
    );
  }

  Widget buildExerciseNotes(MaterialColor pplColor) {
    final notes = widget.exercise.notes;
    if (notes != null) {
      return Column(children: [
        const Divider(height: 8),
        const SizedBox(height: 12),
        SizedBox(
            width: double.infinity,
            child: Text(notes, style: AppTextStyles.body14.apply(
              color: pplColor
            )))
      ]);
    } else {
      return Container();
    }
  }
}
