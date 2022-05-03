import 'package:hive/hive.dart';
import 'package:ppl_course/data/models/exercise/exercise_names.dart';

import '../models/session/session.dart';

class ExerciseRepository {
  static const exerciseBox = 'exerciseBox';
  static const userExercisesPush = 'pushExercises';
  static const userExercisesPull = 'pullExercises';
  static const userExercisesLegs = 'legsExercises';

  final box = Hive.box(exerciseBox);

  final List<String> _pushDefaults = [
    "Overhead Press",
    "Bench Press",
    "Dumbbell Press",
    "Lat Raises",
  ];
  final List<String> _pullDefaults = [
    "Deadlifts",
    "Chinups",
    "Pullups",
    "Face Pulls",
    "Hammer Curls",
    "Dumbbell Curls",
  ];
  final List<String> _legsDefaults = [
    "Squats",
    "Romanian Deadlifts",
    "Leg Curls",
    "Leg Press",
    "Calf Raises",
  ];

  List<String> getExerciseNamesOfType(SessionType type) {
    switch (type) {
      case SessionType.push:
        final list = box.get(userExercisesPush) as ExerciseNames?;
        if (list != null) return _pushDefaults + list.names;
        return _pushDefaults;
      case SessionType.pull:
        final list = box.get(userExercisesPull) as ExerciseNames?;
        if (list != null) return _pullDefaults + list.names;
        return _pullDefaults;
      case SessionType.legs:
        final list = box.get(userExercisesLegs) as ExerciseNames?;
        if (list != null) return _legsDefaults + list.names;
        return _legsDefaults;
    }
  }

  void _updateExerciseList(String typeKey, String name) {
    final list = box.get(typeKey) as ExerciseNames?;
    if (list != null) {
      list.names.add(name);
      box.put(typeKey, list);
    } else {
      box.put(typeKey, ExerciseNames([name]));
    }
  }

  void addExerciseName(String name, SessionType type) {
    switch (type) {
      case SessionType.push:
        _updateExerciseList(userExercisesPush, name);
        break;
      case SessionType.pull:
        _updateExerciseList(userExercisesPull, name);
        break;
      case SessionType.legs:
        _updateExerciseList(userExercisesLegs, name);
        break;
    }
  }
}
