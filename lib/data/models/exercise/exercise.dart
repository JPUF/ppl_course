import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class Exercise {
  late String name;
  late SetsReps setsReps;
  Weight? weight;
  String? notes;

  Exercise.weighted(this.name, this.setsReps, this.weight, this.notes);
  Exercise.noWeight(this.name, this.setsReps, this.notes);
}