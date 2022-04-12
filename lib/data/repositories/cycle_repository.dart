import 'package:ppl_course/data/models/cycle/cycle.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';

class CycleRepository {
  final List<Cycle> _cycles = [
    Cycle([
      Session(1, SessionType.pull, [
        Exercise.weighted(
            name: 'Deadlifts',
            setsReps: SetsReps.endSetOnly(5),
            weight: Weight(70)),
        Exercise.weighted(
            name: 'Pulldowns/Pullups/Chinups',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Chest Supported Rows/Seated Cable Rows',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(20)),
        Exercise.weighted(
            name: 'Face Pulls',
            setsReps: SetsReps.range(5, 15, 20),
            weight: Weight(8)),
        Exercise.weighted(
            name: 'Hammer Curls',
            setsReps: SetsReps.range(4, 8, 12),
            weight: Weight(10)),
        Exercise.weighted(
            name: 'Bicep Curls',
            setsReps: SetsReps.range(4, 8, 12),
            weight: Weight(10))
      ]),
      Session(2, SessionType.push, [
        Exercise.weighted(
            name: 'Bench Press',
            setsReps: SetsReps.fixedEndSet(4, 5, 5),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Overhead Press',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(15.5)),
        Exercise.weighted(
            name: 'Incline Dumbbell Press',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(15.5)),
        Exercise.weighted(
            name: 'Triceps Pushdowns',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(12.5)),
        Exercise.weighted(
            name: 'Overhead Tri Extends',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(12.5)),
      ]),
      Session(3, SessionType.legs, [
        Exercise.weighted(
            name: 'Squat',
            setsReps: SetsReps.fixedEndSet(2, 5, 5),
            weight: Weight(80)),
        Exercise.weighted(
            name: 'Romanian Deadlift',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(50)),
        Exercise.weighted(
            name: 'Leg Press',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(80)),
        Exercise.weighted(
            name: 'Leg Curls',
            setsReps: SetsReps.range(3, 8, 12),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Calf Raises',
            setsReps: SetsReps.range(5, 8, 12),
            weight: Weight(12.5)),
      ]),
    ])
  ];

  List<Cycle> getCycles() {
    return _cycles;
  }

  Session? getSession(SessionArgs sessionArgs) {
    final cn = sessionArgs.cycleNumber;
    final sn = sessionArgs.sessionNumber;
    if (cn < _cycles.length) {
      if (sn < _cycles[cn].sessions.length) {
        return _cycles[cn].sessions[sn];
      }
    }
    return null;
  }
}
