import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/add_exercise_button.dart';
import 'components/bottom_sheet_header.dart';
import 'components/exercise_bottom_sheet.dart';
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

  SessionType _type = SessionType.push;
  String? _notesText;

  final Map<int, Exercise> _exerciseMap = {};
  int newExerciseCount = 0;

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
            style: AppTextStyles.barTitle,
          ),
          actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () => submitSession(),
                    child: Text(Strings.genericDone,
                        style:
                            AppTextStyles.button.apply(color: AppColor.dark))))
          ],
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
                    PplSelectorSwitch(onChanged: (newType) {
                      setState(() {
                        _type = newType;
                      });
                    }),
                    const SizedBox(height: 32),
                    CustomTextField(
                        hint: Strings.generalNotesHint,
                        controller: _editNotesController,
                        focusNode: _notesFocusNode,
                        primaryColor: AppColor.getPplColor(_type),
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
                    child: AddExerciseButton(
                        onTap: () => showBottomSheet(AddEditContext.add))))
          ],
        ),
      ),
    );
  }

  void showBottomSheet(AddEditContext addEditContext,
      [Exercise? exerciseToEdit, int? keyToEdit]) {
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
                  BottomSheetHeader(
                      context: context, addEditContext: addEditContext),
                  Expanded(
                      child: exerciseBottomSheet(
                          addEditContext, exerciseToEdit, keyToEdit)),
                ],
              ));
        });
  }

  ExerciseBottomSheet exerciseBottomSheet(
      AddEditContext addEditContext, Exercise? exerciseToEdit, int? keyToEdit) {
    return ExerciseBottomSheet(
        addEditContext: addEditContext,
        sessionType: _type,
        previousExercise: exerciseToEdit,
        onDeleteExercise: () {
          if (addEditContext == AddEditContext.edit) {
            if (keyToEdit != null) {
              onDeletedExercise(keyToEdit);
            }
          }
        },
        onSubmitExercise: (newExercise) {
          if (addEditContext == AddEditContext.add) {
            onNewExercise(newExercise);
          } else {
            if (keyToEdit != null) {
              onUpdatedExercise(keyToEdit, newExercise);
            }
          }
        });
  }

  void onNewExercise(Exercise exercise) {
    newExerciseCount++;
    setState(() {
      _exerciseMap[newExerciseCount] = exercise;
    });
  }

  void onUpdatedExercise(int keyToEdit, Exercise updatedExercise) {
    setState(() {
      _exerciseMap[keyToEdit] = updatedExercise;
    });
  }

  void onDeletedExercise(int keyToDelete) {
    setState(() {
      _exerciseMap.remove(keyToDelete);
    });
  }

  Widget buildExerciseList() {
    final List<Widget> exerciseWidgets = _exerciseMap.entries
        .map((e) => GestureDetector(
            onTap: () => editExercise(e.value, e.key),
            child: PlanExerciseWidget(exercise: e.value, sessionType: _type)))
        .toList();
    return Column(children: exerciseWidgets);
  }

  editExercise(Exercise exercise, int key) {
    showBottomSheet(AddEditContext.edit, exercise, key);
  }

  void submitSession() {
    String? notes = _notesText;
    if (notes != null) {
      if (notes.isEmpty) {
        notes = null;
      }
    }
    if (_exerciseMap.isNotEmpty) {
      final session = Session(_type, _notesText, _exerciseMap.values.toList());
      BlocProvider.of<SessionsBloc>(context).add(WriteSession(session));
    }
    navigateBack();
  }

  void navigateBack() => Navigator.pop(context);
}
