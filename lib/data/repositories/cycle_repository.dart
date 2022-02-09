import 'package:ppl_course/data/models/cycle/cycle.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';

class CycleRepository {
  final List<Cycle> _cycles = [
    Cycle(
      [
        Session(
            1,
            SessionType.pull,
            [
              Exercise('Deadlifts', SetsReps.endSetOnly(5)),
              Exercise('Pulldowns/Pullups/Chinups', SetsReps.range(3, 8, 12)),
              Exercise('Chest Supported Rows/Seated Cable Rows', SetsReps.range(3, 8, 12)),
              Exercise('Face Pulls', SetsReps.range(5, 15, 20)),
              Exercise('Hammer Curls', SetsReps.range(4, 8, 12)),
              Exercise('Bicep Curls', SetsReps.range(4, 8, 12))
            ]
        )
      ]
    )
  ];

  List<Cycle> getCycles() {
    return _cycles;
  }
}