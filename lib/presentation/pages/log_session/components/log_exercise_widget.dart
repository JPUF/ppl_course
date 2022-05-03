import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/plan_session/components/exercise_card_header.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class LogExerciseWidget extends StatefulWidget {
  const LogExerciseWidget({
    Key? key,
    required Exercise exercise,
    required SessionType sessionType,
  })  : _exercise = exercise,
        _type = sessionType,
        super(key: key);

  final Exercise _exercise;
  final SessionType _type;

  @override
  State<LogExerciseWidget> createState() => _LogExerciseWidgetState();
}

class _LogExerciseWidgetState extends State<LogExerciseWidget>
    with SingleTickerProviderStateMixin {
  final Map<int, int> _completedRepMap = {};

  bool _isExpanded = false;

  late int reps;

  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    reps = widget._exercise.setsReps.reps;
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    for (int s = 1; s <= widget._exercise.setsReps.sets; s++) {
      _completedRepMap[s] = reps;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor _pplColor = AppColor.getPplColor(widget._type);

    final List<Widget> _completedSetRows = [];
    _completedRepMap.forEach((set, completedReps) {
      _completedSetRows.add(buildCompletedSetRow(set, completedReps));
    });

    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
        },
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                color: _pplColor.shade50,
                borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(children: <Widget>[
              ExerciseCardHeader(
                  exercise: widget._exercise, pplColor: _pplColor),
              AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  child: buildLogContent(
                      _isExpanded, _pplColor, _completedSetRows))
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildLogContent(bool isExpanded, MaterialColor _pplColor,
      List<Widget> _completedSetRows) {
    return SizedBox(
      height: _isExpanded ? null : 0,
      child: Column(
        children: [
          Divider(color: _pplColor, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(Strings.logSetNumber, style: AppTextStyles.body14),
                        Text(Strings.logCompletedReps,
                            style: AppTextStyles.body14)
                      ],
                    ),
                  ] +
                  _completedSetRows,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCompletedSetRow(int setNumber, int repCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("$setNumber", style: AppTextStyles.headline3),
          Row(children: [
            IconButton(
                onPressed: () => decrementRepCount(setNumber),
                icon: const Icon(Icons.remove)),
            Text("$repCount", style: AppTextStyles.headline3),
            IconButton(
                onPressed: () => incrementRepCount(setNumber),
                icon: const Icon(Icons.add)),
          ])
        ],
      ),
    );
  }

  void incrementRepCount(int setNumber) {
    final current = _completedRepMap[setNumber];
    if (current != null && current < 25) {
      setState(() {
        _completedRepMap[setNumber] = current + 1;
      });
    }
  }

  void decrementRepCount(int setNumber) {
    final current = _completedRepMap[setNumber] ?? -1;
    if (current > 0) {
      setState(() {
        _completedRepMap[setNumber] = current - 1;
      });
    }
  }
}
