import 'dart:convert';

import 'package:ppl_course/data/models/exercise/exercise.dart';

class Session {
  final SessionType type;
  final String? notes;
  final List<Exercise> exercises;

  Session(this.type, this.notes, this.exercises);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'type': type.index.toString()});
    result.addAll({'notes': notes});
    result.addAll({'exercises': exercises.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    final type = SessionType.values[int.parse(map['type'])];
    final notes = map['notes'];
    final exercises =
        (map['exercises'] as List).map((e) => Exercise.fromMap(e)).toList();
    return Session(
      type,
      notes,
      exercises,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));
}

enum SessionType { push, pull, legs }

extension SessionString on SessionType {
  String toSessionString() {
    switch (this) {
      case SessionType.push:
        return 'Push';
      case SessionType.pull:
        return 'Pull';
      case SessionType.legs:
        return 'Legs';
    }
  }
}
