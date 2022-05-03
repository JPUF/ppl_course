import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import '../plan_session/session_args.dart';
import 'components/log_exercise_widget.dart';

class LogSessionPage extends StatefulWidget {
  const LogSessionPage({Key? key}) : super(key: key);

  @override
  State<LogSessionPage> createState() => _LogSessionPageState();
}

class _LogSessionPageState extends State<LogSessionPage> {
  late Session _session;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as SessionArgs;
    _session = args.session!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.logSessionType(_session.type.toSessionString()),
          style: AppTextStyles.barTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
              children: _session.exercises
                  .map((e) => LogExerciseWidget(exercise: e))
                  .toList()),
        ),
      ),
    );
  }
}
