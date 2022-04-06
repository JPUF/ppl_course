import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/presentation/pages/home/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({Key? key, required this.session}) : super(key: key);

  final Session session;

  List<Widget> buildExerciseList() {
    var exerciseWidgets = <Widget>[];
    for (var exercise in session.exercises) {
      exerciseWidgets.add(ExerciseWidget(exercise: exercise));
      if (exercise != session.exercises.last) {
        exerciseWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Divider(color: AppColor.light, thickness: 1),
        ));
      }
    }
    return exerciseWidgets;
  }

  @override
  State<SessionWidget> createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Card(
        elevation: 16,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.secondary,
              border: Border.all(color: AppColor.dark),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('${widget.session.sessionNumber}',
                        style: Theme.of(context).textTheme.headline3),
                    const SizedBox(width: 16),
                    Text(widget.session.type.toSessionString(),
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(color: AppColor.light, thickness: 2),
              ),
              Column(children: widget.buildExerciseList()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
