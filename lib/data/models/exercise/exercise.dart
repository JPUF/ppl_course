import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class Exercise {
  late String name;
  late SetsReps setsReps;
  Weight? weight;

  Exercise(this.name, this.setsReps);
}