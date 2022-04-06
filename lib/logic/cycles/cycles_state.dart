part of 'cycles_bloc.dart';

abstract class CyclesState {}

class AllCyclesState extends CyclesState {
  late List<Cycle> cycles;
}

class SessionState extends CyclesState {
  late Session session;
}