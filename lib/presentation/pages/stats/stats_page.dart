import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/data/models/session/date_time_weight.dart';
import 'package:ppl_course/presentation/pages/stats/components/progression_chart.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  List<DateTimeWeight> completedSessions() {
    final s = <DateTimeWeight>[];
    final r = Random();
    const l = -1;
    for (int i = 1; i < 10; i++) {
      final v = l + r.nextDouble();
      s.add(DateTimeWeight(
        DateTimeDay(2022, 1, i),
        Weight(i + 20 + v),
      ));
    }
    return s;
  }

  static List<charts.Series<DateTimeWeight, DateTime>> _createSampleData() {
    final data = [
      DateTimeWeight(DateTime(2017, 9, 19), Weight(5)),
      DateTimeWeight(DateTime(2017, 9, 26), Weight(25)),
      DateTimeWeight(DateTime(2017, 10, 3), Weight(100)),
      DateTimeWeight(DateTime(2017, 10, 10), Weight(75)),
    ];

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
            ProgressionChart(seriesList: _createSampleData())
          ],
        ),
      ),
    );
  }
}
