import 'package:ppl_course/data/models/exercise/exercise.dart';

class Session {
  late int cycleNumber;
  late SessionType type;
  late List<Exercise> exercises;

  Session(this.cycleNumber, this.type, this.exercises);
}

enum SessionType {
  push, pull, legs
}