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
}
