import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/log_session/components/log_exercise_widget.dart';
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

  @override
  void initState() {
    super.initState();
    for (var exercise in widget.session.exercises) {
      expandedExerciseMap[exercise] = false;
    }
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
              children: expandedExerciseMap.keys
                  .map((e) => LogExerciseWidget(
                      exercise: e,
                      type: widget.session.type,
                      isExpanded: expandedExerciseMap[e] ?? false,
                      onToggleExpanded: (isExpanded) {
                        foldAllExercises();
                        setState(() => expandedExerciseMap[e] = isExpanded);
                      }))
                  .toList(),
            ),
          ),
        ));
  }

  void foldAllExercises() {
    expandedExerciseMap
        .updateAll((key, value) => expandedExerciseMap[key] = false);
  }
}
