import '../models/session/session.dart';

class ExerciseRepository {
  final List<String> _pushExercises = [
    "Overhead Press",
    "Bench Press",
    "Dumbbell Press",
    "Lat Raises",
  ];
  final List<String> _pullExercises = [
    "Deadlifts",
    "Chinups",
    "Face Pulls",
  ];
  final List<String> _legsExercises = [
    "Squats",
    "Romanian Deadlifts",
    "Leg Curls",
  ];

  List<String> getExerciseNamesOfType(SessionType type) {
    switch (type) {
      case SessionType.push:
        return _pushExercises;
      case SessionType.pull:
        return _pullExercises;
      case SessionType.legs:
        return _legsExercises;
    }
  }

  void addExerciseName(String name, SessionType type) {
    switch (type) {
      case SessionType.push:
        _pushExercises.add(name);
        break;
      case SessionType.pull:
        _pushExercises.add(name);
        break;
      case SessionType.legs:
        _pullExercises.add(name);
        break;
    }
  }
}
