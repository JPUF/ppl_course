import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/data/repositories/exercise_repository.dart';

part 'exercises_state.dart';

abstract class ExercisesEvent {}

class FetchExerciseNamesOfType implements ExercisesEvent {
  final SessionType type;

  FetchExerciseNamesOfType(this.type);
}

class WriteExerciseName implements ExercisesEvent {
  final String name;
  final SessionType type;

  WriteExerciseName(this.name, this.type);
}

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  ExercisesBloc() : super(InitialState()) {
    on<FetchExerciseNamesOfType>(_fetchExerciseNamesOfType);
    on<WriteExerciseName>(_writeExerciseName);
  }

  void _fetchExerciseNamesOfType(
      FetchExerciseNamesOfType event, Emitter<ExercisesState> emit) async {
    final exerciseNames =
        _exerciseRepository.getExerciseNamesOfType(event.type);
    emit(ExerciseNamesOfTypeState(exerciseNames));
  }

  void _writeExerciseName(
      WriteExerciseName event, Emitter<ExercisesState> emit) async {
    _exerciseRepository.addExerciseName(event.name, event.type);
    final exerciseNames =
        _exerciseRepository.getExerciseNamesOfType(event.type);
    emit(ExerciseNamesOfTypeState(exerciseNames));
  }
}
