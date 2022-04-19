import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/data/models/session/cycle.dart';
import 'package:ppl_course/data/models/session/session.dart';

class SessionRepository {
  final List<Cycle> _cycles = [
    Cycle([
      Session(SessionType.pull, "notes", [
        Exercise.weighted(
            name: 'Deadlifts',
            setsReps: SetsReps(sets: 1, reps: 5, amrapFinalSet: true),
            weight: Weight(70)),
        Exercise.weighted(
            name: 'Pulldowns/Pullups/Chinups',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Chest Supported Rows/Seated Cable Rows',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(20)),
        Exercise.weighted(
            name: 'Face Pulls',
            setsReps: SetsReps(sets: 5, reps: 15),
            weight: Weight(8)),
        Exercise.weighted(
            name: 'Hammer Curls',
            setsReps: SetsReps(sets: 4, reps: 8),
            weight: Weight(10)),
        Exercise.weighted(
            name: 'Bicep Curls',
            setsReps: SetsReps(sets: 4, reps: 8),
            weight: Weight(10))
      ]),
      Session(SessionType.push, "notes", [
        Exercise.weighted(
            name: 'Bench Press',
            setsReps: SetsReps(sets: 4, reps: 5, amrapFinalSet: true),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Overhead Press',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(15.5)),
        Exercise.weighted(
            name: 'Incline Dumbbell Press',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(15.5)),
        Exercise.weighted(
            name: 'Triceps Pushdowns',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(12.5)),
        Exercise.weighted(
            name: 'Overhead Tri Extends',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(12.5)),
      ]),
      Session(SessionType.legs, "notes", [
        Exercise.weighted(
            name: 'Squat',
            setsReps: SetsReps(sets: 2, reps: 5, amrapFinalSet: true),
            weight: Weight(80)),
        Exercise.weighted(
            name: 'Romanian Deadlift',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(50)),
        Exercise.weighted(
            name: 'Leg Press',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(80)),
        Exercise.weighted(
            name: 'Leg Curls',
            setsReps: SetsReps(sets: 3, reps: 8),
            weight: Weight(30)),
        Exercise.weighted(
            name: 'Calf Raises',
            setsReps: SetsReps(sets: 5, reps: 8),
            weight: Weight(12.5)),
      ]),
    ])
  ];

  final List<Session> _sessions = [];

  List<Session> getAllSessions() {
    return _sessions;
  }

  bool writeSession(Session session) {
    _sessions.add(session);
    return true;
  }
}
