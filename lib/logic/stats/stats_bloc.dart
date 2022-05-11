import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/data/models/session/date_time_weight.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(StatsInitial()) {
    on<TotalVolumeEvent>(_onTotalVolume);
  }

  List<DateTimeWeight> completedSessions() {
    final s = <DateTimeWeight>[];
    final r = Random();
    const l = -1;
    for (int i = 1; i < 10; i++) {
      final v = l + r.nextDouble();
      s.add(DateTimeWeight(
        DateTimeDay(2022, 1, i * 4),
        Weight(i + 20 + v),
      ));
    }
    return s;
  }

  //TODO needs to be read from session repo. So requires DI for the repo.
  List<charts.Series<DateTimeWeight, DateTime>> _createSampleData() {
    final data = completedSessions();

    return [
      charts.Series<DateTimeWeight, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DateTimeWeight entry, _) => entry.dateTime,
        measureFn: (DateTimeWeight entry, _) => entry.weight.kg,
        data: data,
      )
    ];
  }

  void _onTotalVolume(TotalVolumeEvent event, Emitter<StatsState> emit) {
    emit(TotalVolumeState(_createSampleData()));
  }
}
