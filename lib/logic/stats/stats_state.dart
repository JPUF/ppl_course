part of 'stats_bloc.dart';

@immutable
abstract class StatsState {}

class StatsInitial extends StatsState {}

class TotalVolumeState extends StatsState {
  final List<charts.Series<DateTimeWeight, DateTime>> series;

  TotalVolumeState(this.series);
}

class InsufficientDataState extends StatsState {}
