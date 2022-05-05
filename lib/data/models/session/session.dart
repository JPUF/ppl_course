import 'dart:convert';

import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:uuid/uuid.dart';

class Session {
  late final String uuid;
  final SessionType type;
  final DateTimeDay day;
  final String? notes;
  final List<Exercise> exercises;

  bool completed = false;

  Session(this.type, this.day, this.notes, this.exercises) {
    uuid = const Uuid().v1();
  }

  Session.withUuid(
      {required this.uuid,
      required this.type,
      required this.day,
      this.notes,
      required this.exercises,
      this.completed = false});

  void completeSession() {
    completed = true;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'uuid': uuid});
    result.addAll({'type': type.index.toString()});
    result.addAll({'day': day.toIso8601String()});
    result.addAll({'notes': notes});
    result.addAll({'exercises': exercises.map((x) => x.toMap()).toList()});
    result.addAll({'completed': completed});

    return result;
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    final uuid = map['uuid'];
    final type = SessionType.values[int.parse(map['type'])];
    final DateTimeDay day =
        DateTimeDay.fromDateTime(DateTime.parse(map['day']));
    final notes = map['notes'];
    final completed = map['completed'];
    final exercises =
        (map['exercises'] as List).map((e) => Exercise.fromMap(e)).toList();
    return Session.withUuid(
      uuid: uuid,
      type: type,
      day: day,
      notes: notes,
      exercises: exercises,
      completed: completed,
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
