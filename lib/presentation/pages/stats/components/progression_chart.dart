import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({Key? key, required this.dataSpots}) : super(key: key);

  final List<FlSpot> dataSpots;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      chartData,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get chartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: FlGridData(show: false),
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [barData],
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      "${value.toInt().toString()}kg",
      style: AppTextStyles.chartAxisTitle,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Padding(
        child: Text("${value.toInt()}", style: AppTextStyles.chartAxisTitle),
        padding: const EdgeInsets.only(top: 10.0));
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 2,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColor.transparent),
          left: BorderSide(color: AppColor.transparent),
          right: BorderSide(color: AppColor.transparent),
          top: BorderSide(color: AppColor.transparent),
        ),
      );

  LineChartBarData get barData => LineChartBarData(
        isCurved: true,
        color: AppColor.accent,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dataSpots,
      );
}

class ProgressionChart extends StatefulWidget {
  const ProgressionChart({Key? key, required this.dataSpots}) : super(key: key);

  final List<FlSpot> dataSpots;

  @override
  State<StatefulWidget> createState() => ProgressionChartState();
}

class ProgressionChartState extends State<ProgressionChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            transform: const GradientRotation(0.1),
            colors: [
              AppColor.dark,
              AppColor.dark.shade800,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Text(
                Strings.progressionChartTitle,
                style: AppTextStyles.headline3.apply(color: AppColor.white),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: _LineChart(dataSpots: widget.dataSpots),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
