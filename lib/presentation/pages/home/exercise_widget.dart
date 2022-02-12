import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;


  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Text(widget.exercise.name,
                  style: Theme.of(context).textTheme.bodyText1)),
          Expanded(
              flex: 3,
              child: Text(widget.exercise.setsReps.toString(),
                  style: Theme.of(context).textTheme.bodyText1)),
          Expanded(
              flex: 2,
              child: Text(widget.exercise.weight?.toString() ?? 'N/A',
                  style: Theme.of(context).textTheme.bodyText1))
        ],
      ),
    );
  }
}
