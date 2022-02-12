import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/presentation/pages/home/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.secondary, borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text("1", style: Theme.of(context).textTheme.headline3),
                const SizedBox(width: 16),
                Text("Pull", style: Theme.of(context).textTheme.headline4)
              ],
            ),
          ),
          Divider(color: AppColor.dark, thickness: 2),
          ExerciseWidget(exercise: Exercise.weighted("Deadlifts", SetsReps.endSetOnly(5), Weight(100.5))),
          Divider(color: AppColor.dark, thickness: 1),
          ExerciseWidget(exercise: Exercise.weighted("Pulldowns", SetsReps.range(3, 8, 12), Weight(30.0))),
          Divider(color: AppColor.dark, thickness: 1),
          ExerciseWidget(exercise: Exercise.weighted("Chest Supported Rows", SetsReps.range(3, 8, 12), Weight(10.0))),
          Divider(color: AppColor.dark, thickness: 1),
          ExerciseWidget(exercise: Exercise.weighted("Face Pulls", SetsReps.range(5, 15, 20), Weight(5.0))),
          Divider(color: AppColor.dark, thickness: 1),
          ExerciseWidget(exercise: Exercise.weighted("Hammer Curls", SetsReps.range(4, 8, 12), Weight(10.0))),
          Divider(color: AppColor.dark, thickness: 1),
          ExerciseWidget(exercise: Exercise.weighted("Bicep Curls", SetsReps.range(4, 8, 12), Weight(10.0))),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
