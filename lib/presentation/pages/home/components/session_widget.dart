import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/home/components/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({Key? key, required this.session, required this.onTappedLog, required this.onTappedEdit}) : super(key: key);

  final Session session;
  final VoidCallback onTappedLog;
  final VoidCallback onTappedEdit;

  List<Widget> buildExerciseList() {
    var exerciseWidgets = <Widget>[];
    for (var exercise in session.exercises) {
      exerciseWidgets.add(ExerciseWidget(
        exercise: exercise,
        sessionType: session.type,
      ));
      if (exercise != session.exercises.last) {
        exerciseWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child:
              Divider(color: AppColor.getPplColor(session.type), thickness: 1),
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
              color: AppColor.getPplColor(widget.session.type).shade50,
              border: Border.all(
                  color: AppColor.getPplColor(widget.session.type), width: 3),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              sessionHeader(),
              buildNotes(),
              thickDivider(),
              Column(children: widget.buildExerciseList()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget sessionHeader() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.session.type.toSessionString(),
                style: AppTextStyles.headline3
                    .apply(color: AppColor.getPplColor(widget.session.type))),
          ),
          IconButton(
              color: AppColor.getPplColor(widget.session.type),
              onPressed: () => widget.onTappedLog(),
              icon: const Icon(Icons.play_arrow)),
          IconButton(
              color: AppColor.getPplColor(widget.session.type),
              onPressed: () => widget.onTappedEdit(),
              icon: const Icon(Icons.edit))
        ],
      ),
    );
  }

  Widget thickDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(
          color: AppColor.getPplColor(widget.session.type), thickness: 2),
    );
  }

  Widget buildNotes() {
    List<Widget> widgets = [];
    final notes = widget.session.notes;
    if (notes != null) {
      widgets = [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Text(notes,
                style: AppTextStyles.body14
                    .apply(color: AppColor.getPplColor(widget.session.type))))
      ];
    }
    return Column(children: widgets);
  }
}
