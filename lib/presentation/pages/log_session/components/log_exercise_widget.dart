import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/exercise_log.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/plan_session/components/exercise_card_header.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class LogExerciseWidget extends StatefulWidget {
  const LogExerciseWidget(
      {Key? key,
      required this.exercise,
      required this.type,
      required this.isExpanded,
      required this.onToggleExpanded,
      required this.onExerciseLogUpdated})
      : super(key: key);

  final Exercise exercise;
  final SessionType type;
  final bool isExpanded;
  final ValueSetter<bool> onToggleExpanded;
  final ValueSetter<ExerciseLog> onExerciseLogUpdated;

  @override
  State<LogExerciseWidget> createState() => _LogExerciseWidgetState();
}

class _LogExerciseWidgetState extends State<LogExerciseWidget>
    with SingleTickerProviderStateMixin {

  final Map<int, int> _completedRepMap = {};
  late int reps;
  late AnimationController animController;
  late final MaterialColor _pplColor;

  @override
  void initState() {
    super.initState();
    reps = widget.exercise.setsReps.reps;
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    for (int s = 1; s <= widget.exercise.setsReps.sets; s++) {
      _completedRepMap[s] = reps;
    }

    _pplColor = AppColor.getPplColor(widget.type);
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _completedSetRows = [];
    _completedRepMap.forEach((set, completedReps) {
      _completedSetRows.add(buildCompletedSetRow(set, completedReps));
    });

    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
              color: _pplColor.shade50, borderRadius: BorderRadius.circular(4)),
          child: Column(children: <Widget>[
            InkWell(
              onTap: () {
                widget.onToggleExpanded(!widget.isExpanded);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ExerciseCardHeader(
                    exercise: widget.exercise, pplColor: _pplColor),
              ),
            ),
            AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: buildLogContent(_completedSetRows))
          ]),
        ),
      ),
    );
  }

  Widget buildLogContent(List<Widget> _completedSetRows) {
    return SizedBox(
      height: widget.isExpanded ? null : 0,
      child: Column(
        children: [
          buildNotesText(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: buildCompletedSetHeader() +
                  _completedSetRows +
                  buildVolumeFooter(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNotesText() {
    final notes = widget.exercise.notes;
    if(notes != null) {
      return Text(notes, style: AppTextStyles.body14.apply(
        color: _pplColor,
        fontStyle: FontStyle.italic
      ));
    } else {
      return Container();
    }
  }

  List<Widget> buildCompletedSetHeader() {
    return [
      Row(
        children: [
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(Strings.logSetNumber, style: AppTextStyles.body14.apply(
                  color: _pplColor
                )),
              )),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child:
                  Text(Strings.logCompletedReps, style: AppTextStyles.body14.apply(
                    color: _pplColor
                  )),
            ),
          )
        ],
      )
    ];
  }

  Widget buildCompletedSetRow(int setNumber, int repCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.center,
                  child: Text("$setNumber", style: AppTextStyles.headline3.apply(
                    color: _pplColor
                  )))),
          Expanded(
            flex: 2,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  onPressed: () => decrementRepCount(setNumber),
                  icon: Icon(Icons.remove, color: _pplColor)),
              Text("$repCount", style: AppTextStyles.headline3.apply(
                color: _pplColor
              )),
              IconButton(
                  onPressed: () => incrementRepCount(setNumber),
                  icon: Icon(Icons.add, color: _pplColor)),
            ]),
          )
        ],
      ),
    );
  }

  List<Widget> buildVolumeFooter() {
    return [
      Center(
          child: Column(
            children: [
              Text(Strings.logVolume, style: AppTextStyles.body14.apply(
                color: _pplColor
              )),
              Text(
                createExerciseLog().volume.toString(),
                style: AppTextStyles.headline3.apply(
                  color: _pplColor
                ),
              )
            ],
          )),
      const SizedBox(height: 8),
    ];
  }

  void incrementRepCount(int setNumber) {
    final current = _completedRepMap[setNumber];
    if (current != null && current < 25) {
      setState(() {
        _completedRepMap[setNumber] = current + 1;
      });
      notifyExerciseLogUpdated();
    }
  }

  void decrementRepCount(int setNumber) {
    final current = _completedRepMap[setNumber] ?? -1;
    if (current > 0) {
      setState(() {
        _completedRepMap[setNumber] = current - 1;
      });
      notifyExerciseLogUpdated();
    }
  }

  ExerciseLog createExerciseLog() {
    return ExerciseLog(widget.exercise, _completedRepMap.values.toList());
  }

  void notifyExerciseLogUpdated() {
    widget.onExerciseLogUpdated(createExerciseLog());
  }
}
