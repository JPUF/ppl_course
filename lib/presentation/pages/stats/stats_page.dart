import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/progression_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  final sessionDataSpots = const [
    FlSpot(1, 1),
    FlSpot(3, 1.5),
    FlSpot(5, 1.4),
    FlSpot(7, 3.4),
    FlSpot(10, 2),
    FlSpot(12, 2.2),
    FlSpot(13, 1.8),
  ];

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
            ProgressionChart(dataSpots: sessionDataSpots),
          ],
        ),
      ),
    );
  }
}
