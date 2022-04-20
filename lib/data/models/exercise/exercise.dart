import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class Exercise {
  late String name;
  late SetsReps setsReps;
  Weight? weight;
  String? notes;

  Exercise.weighted(
      {required this.name, required this.setsReps, this.weight, this.notes});

  Exercise.noWeight({required this.name, required this.setsReps, this.notes});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'setsReps': setsReps.toMap(),
      'weight': weight?.toMap(),
      'notes': notes,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise.weighted(
      name: map['name'] as String,
      setsReps: SetsReps.fromMap(map['setsReps']),
      weight: Weight.fromMap(map['weight']),
      notes: map['notes'] as String?,
    );
  }
}
