import 'package:ppl_course/data/models/exercise/exercise.dart';

class Session {
  late int sessionNumber;
  late SessionType type;
  late List<Exercise> exercises;

  Session(this.sessionNumber, this.type, this.exercises);
}

enum SessionType {
  push, pull, legs
}

extension SessionString on SessionType {
  String toSessionString() {
    switch(this) {
      case SessionType.push:
        return 'Push';
      case SessionType.pull:
        return 'Pull';
      case SessionType.legs:
        return 'Legs';
    }
  }
}