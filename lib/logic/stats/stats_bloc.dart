import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ppl_course/data/models/session/date_time_weight.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/data/repositories/session_repository.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final SessionRepository _sessionRepository;

  StatsBloc(this._sessionRepository) : super(StatsInitial()) {
    on<TotalVolumeEvent>(_onTotalVolume);
  }

  List<charts.Series<DateTimeWeight, DateTime>> _createChartData(
      List<DateTimeWeight> points) {
    return [
      charts.Series<DateTimeWeight, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DateTimeWeight entry, _) => entry.dateTime,
        measureFn: (DateTimeWeight entry, _) => entry.weight.kg,
        data: points,
      )
    ];
  }

  List<DateTimeWeight> _mapToDateTimeWeight(List<Session> sessions) {
    return sessions.map((s) => DateTimeWeight(s.day, s.totalVolume())).toList();
  }

  void _onTotalVolume(TotalVolumeEvent event, Emitter<StatsState> emit) {
    final completedSessions = _sessionRepository.getAllCompletedSessions();
    if(completedSessions.isNotEmpty){
      emit(TotalVolumeState(
        _createChartData(_mapToDateTimeWeight(completedSessions)),
      ));
    } else {
      emit(InsufficientDataState());
    }
  }
}
