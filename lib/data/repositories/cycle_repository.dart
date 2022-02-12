import 'package:ppl_course/data/models/cycle/cycle.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';

class CycleRepository {
  final List<Cycle> _cycles = [
    Cycle(
      [
        Session(
            1,
            SessionType.pull,
            [
              Exercise.weighted('Deadlifts', SetsReps.endSetOnly(5), Weight(70)),
              Exercise.weighted('Pulldowns/Pullups/Chinups', SetsReps.range(3, 8, 12), Weight(30)),
              Exercise.weighted('Chest Supported Rows/Seated Cable Rows', SetsReps.range(3, 8, 12), Weight(20)),
              Exercise.weighted('Face Pulls', SetsReps.range(5, 15, 20), Weight(8)),
              Exercise.weighted('Hammer Curls', SetsReps.range(4, 8, 12), Weight(10)),
              Exercise.weighted('Bicep Curls', SetsReps.range(4, 8, 12), Weight(10))
            ]
        )
      ]
    )
  ];

  List<Cycle> getCycles() {
    return _cycles;
  }
}