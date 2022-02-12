import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class Exercise {
  late String name;
  late SetsReps setsReps;
  Weight? weight;

  Exercise.weighted(this.name, this.setsReps, this.weight);
  Exercise.noWeight(this.name, this.setsReps);
}