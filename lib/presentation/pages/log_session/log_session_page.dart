import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/data/models/exercise/exercise_log.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/pages/log_session/components/log_exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import '../../../data/models/exercise/exercise.dart';

class LogSessionPage extends StatefulWidget {
  const LogSessionPage({Key? key, required this.session}) : super(key: key);

  final Session session;

  @override
  State<LogSessionPage> createState() => _LogSessionPageState();
}

class _LogSessionPageState extends State<LogSessionPage> {
  final Map<Exercise, bool> expandedExerciseMap = {};
  final Map<Exercise, ExerciseLog> exerciseLogMap = {};
  late final MaterialColor _pplColor;

  @override
  void initState() {
    super.initState();
    for (var ex in widget.session.exercises) {
      expandedExerciseMap[ex] = ex == widget.session.exercises.first;
      exerciseLogMap[ex] = ExerciseLog.defaultReps(ex);
    }

    _pplColor = AppColor.getPplColor(widget.session.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.logSessionType(widget.session.type.toSessionString()),
            style: AppTextStyles.barTitle,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Column(
                  children: buildNotesSection() + buildLogWidgetList(),
                ),
                buildFooter()
              ],
            ),
          ),
        ));
  }

  List<Widget> buildNotesSection() {
    final notes = widget.session.notes;
    if (notes != null) {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
          child: Text(notes,
              style: AppTextStyles.body14.apply(
                color: _pplColor,
                fontStyle: FontStyle.italic,
              )),
        ),
      ];
    } else {
      return [];
    }
  }

  List<Widget> buildLogWidgetList() {
    return expandedExerciseMap.keys
        .map((e) => LogExerciseWidget(
              exercise: e,
              type: widget.session.type,
              isExpanded: expandedExerciseMap[e] ?? false,
              onToggleExpanded: (isExpanded) {
                foldAllExercises();
                setState(() => expandedExerciseMap[e] = isExpanded);
              },
              onExerciseLogUpdated: (log) {
                setState(() => exerciseLogMap[e] = log);
              },
            ))
        .toList();
  }

  Widget buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(Strings.logTotal,
                  style: AppTextStyles.body17.apply(color: _pplColor)),
              const SizedBox(width: 8),
              Text(_getTotalVolume().toString(),
                  style: AppTextStyles.headline3.apply(color: _pplColor))
            ],
          ),
          AccentButton(text: Strings.logFinish, onTap: () => completeSession())
        ],
      ),
    );
  }

  Weight _getTotalVolume() {
    double totalKg = 0;
    for (var log in exerciseLogMap.values) {
      totalKg += log.volume.kg;
    }
    return Weight(totalKg);
  }

  void foldAllExercises() {
    expandedExerciseMap.updateAll((key, _) => expandedExerciseMap[key] = false);
  }

  void completeSession() {
    widget.session.completeSession();
    BlocProvider.of<SessionsBloc>(context).add(EditSession(widget.session));
    navigateBack();
  }

  void navigateBack() => Navigator.pop(context);
}
