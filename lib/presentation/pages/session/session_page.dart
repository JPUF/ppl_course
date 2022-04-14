import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/add_exercise_bottom_sheet.dart';
import 'components/add_exercise_button.dart';
import 'components/plan_exercise_widget.dart';
import 'components/ppl_selector_switch.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TextEditingController _editNotesController;
  late FocusNode _notesFocusNode;
  String _notesText = "";

  final List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _editNotesController = TextEditingController(text: _notesText);
    _notesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _editNotesController.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            Strings.planSessionTitle,
            style: AppTextStyles.button.apply(color: AppColor.white),
          ),
          actions: [Container(
            padding: const EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => submitSession(),
                  child: Text("Done", style: AppTextStyles.button.apply(color: AppColor.white),)))],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const PplSelectorSwitch(),
                    const SizedBox(height: 32),
                    CustomTextField(
                        hint: Strings.generalNotesHint,
                        controller: _editNotesController,
                        focusNode: _notesFocusNode,
                        onChanged: (newValue) {
                          setState(() {
                            _notesText = newValue;
                          });
                        }),
                    const SizedBox(height: 16),
                    buildExerciseList(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AddExerciseButton(onTap: () => showBottomSheet())))
          ],
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: 0.85,
              child: Column(
                children: [
                  buildSheetHeader(),
                  Expanded(
                      child: AddExerciseBottomSheet(
                          addExercise: (newExercise) =>
                              onNewExercise(newExercise))),
                ],
              ));
        });
  }

  void onNewExercise(Exercise exercise) {
    setState(() {
      _exercises.add(exercise);
    });
  }

  Widget buildExerciseList() {
    final List<Widget> exerciseWidgets = _exercises
        .map((e) =>
            PlanExerciseWidget(exercise: e, sessionType: SessionType.push))
        .toList();
    return Column(children: exerciseWidgets);
  }

  Widget buildSheetHeader() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 4),
                  child: Text(
                    Strings.exerciseTitle,
                    style: AppTextStyles.headline3.apply(color: AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                )),
            Positioned(
              right: 0,
              top: 0,
              child: MaterialButton(
                onPressed: () => Navigator.pop(context),
                minWidth: 0,
                child: Icon(
                  Icons.close,
                  color: AppColor.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1)
      ],
    );
  }

  void submitSession() {
    navigateBack();
  }

  void navigateBack() => Navigator.pop(context);
}
