import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/presentation/pages/home/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({Key? key, required this.session}) : super(key: key);

  final Session session;

  @override
  State<SessionWidget> createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {
  var exerciseWidgets = <Widget>[];

  void populateExerciseWidgets(List<Exercise> exercises) {
    for (var exercise in exercises) {
      exerciseWidgets.add(ExerciseWidget(exercise: exercise));
      if (exercise != exercises.last) {
        exerciseWidgets.add(Divider(color: AppColor.dark, thickness: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    populateExerciseWidgets(widget.session.exercises);
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
          Column(children: exerciseWidgets),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
