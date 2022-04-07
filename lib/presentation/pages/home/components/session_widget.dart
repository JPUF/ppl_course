import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/presentation/pages/home/components/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

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
          child: Divider(color: AppColor.dark, thickness: 1),
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
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.secondary,
              border: Border.all(
                  color: AppColor.getPplColor(widget.session.type), width: 3),
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
                    Text(widget.session.type.toSessionString(),
                        style: AppTextStyles.headline3.apply(
                            color: AppColor.getPplColor(widget.session.type)))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(color: AppColor.getPplColor(widget.session.type), thickness: 2),
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
