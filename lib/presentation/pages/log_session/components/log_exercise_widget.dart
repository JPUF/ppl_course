import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';

class LogExerciseWidget extends StatelessWidget {
  const LogExerciseWidget({
    Key? key,
    required Exercise exercise,
  })  : _exercise = exercise,
        super(key: key);

  final Exercise _exercise;

  @override
  Widget build(BuildContext context) {
    return Text(_exercise.name);
  }
}
