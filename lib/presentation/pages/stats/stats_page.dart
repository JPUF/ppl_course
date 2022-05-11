import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/data/models/session/session_log.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/progression_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  List<SessionLog> completedSessions() {
    final s = <SessionLog>[];
    final r = Random();
    const l = -1;
    for (int i = 1; i < 10; i++) {
      final v =  l + r.nextDouble();
      s.add(SessionLog(Weight(i + 20 + v), DateTimeDay(2022, 1, i)));
    }
    return s;
  }

  List<FlSpot> logsToSpots() {
    return completedSessions()
        .map((e) => FlSpot(
              e.dateTime.day.toDouble(),
              e.totalVolume.kg,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.progressionTab,
          style: AppTextStyles.barTitle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 8),
            ProgressionChart(dataSpots: logsToSpots()),
          ],
        ),
      ),
    );
  }
}
