import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/logic/stats/stats_bloc.dart';
import 'package:ppl_course/presentation/pages/stats/components/progression_chart.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final chartBuilder = BlocBuilder<StatsBloc, StatsState>(
    builder: (context, state) {
      if (state is TotalVolumeState) {
        return ProgressionChart(seriesList: state.series);
      } else {
        return const Center(child: Text("Insufficient Data"));
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StatsBloc>(context).add(TotalVolumeEvent());
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
            chartBuilder,
          ],
        ),
      ),
    );
  }
}
