part of 'exercises_bloc.dart';

abstract class ExercisesState {}

class InitialState implements ExercisesState {}

class ExerciseNamesOfTypeState implements ExercisesState {
  final List<String> exerciseNamesOfType;

  ExerciseNamesOfTypeState(this.exerciseNamesOfType);
}
