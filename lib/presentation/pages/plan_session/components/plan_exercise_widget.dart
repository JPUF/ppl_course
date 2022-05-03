import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/plan_session/components/exercise_card_header.dart';
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
            color: _pplColor.shade50, borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            ExerciseCardHeader(exercise: widget.exercise, pplColor: _pplColor),
            buildExerciseNotes(_pplColor)
          ],
        ),
      ),
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
            child:
                Text(notes, style: AppTextStyles.body14.apply(color: pplColor)))
      ]);
    } else {
      return Container();
    }
  }
}
