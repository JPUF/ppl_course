import 'package:collection/collection.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

import 'exercise.dart';

class ExerciseLog {
  final Exercise completedExercise;
  late final List<int> completedReps;
  late final Weight volume;

  ExerciseLog(this.completedExercise, this.completedReps) {
    volume = _calculateVolume();
  }

  ExerciseLog.defaultReps(this.completedExercise) {
    final setsReps = completedExercise.setsReps;
    completedReps = List.generate(setsReps.sets, (_) => setsReps.reps);
    volume = _calculateVolume();
  }

  Weight _calculateVolume() {
    final kg = completedExercise.weight?.kg ?? 0.0;
    return Weight(kg * completedReps.sum);
  }
}
