import 'package:ppl_course/data/models/exercise/exercise.dart';

class Session {
  final SessionType type;
  final String notes;
  final List<Exercise> exercises;

  Session(this.type, this.notes, this.exercises);
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