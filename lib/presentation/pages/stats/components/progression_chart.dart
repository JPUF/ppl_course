import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ProgressionChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;

  const ProgressionChart({Key? key, required this.seriesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: charts.TimeSeriesChart(seriesList),
    );
  }
}
