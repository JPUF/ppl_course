import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/pages/session/session_args.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/add_exercise_button.dart';
import 'components/bottom_sheet_header.dart';
import 'components/exercise_bottom_sheet.dart';
import 'components/plan_exercise_widget.dart';
import 'components/ppl_selector_switch.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TextEditingController _editNotesController;
  late FocusNode _notesFocusNode;

  SessionType _type = SessionType.push;
  String? _notesText;

  bool _lastSessionCopied = false;

  Map<int, Exercise> _exerciseMap = {};
  int _newExerciseCount = 0;

  late SessionArgs _editArgs;

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
    _editArgs = ModalRoute.of(context)?.settings.arguments as SessionArgs;
    final sessionToEdit = _editArgs.session;
    if (sessionToEdit != null) {
      populateWithSessionToEdit(sessionToEdit);
    }
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
                    PplSelectorSwitch(
                        initialType: _type,
                        onChanged: (newType) {
                          setState(() {
                            _lastSessionCopied = false;
                            _type = newType;
                          });
                        }),
                    const SizedBox(height: 32),
                    buildNotesTextField(),
                    buildCopyPreviousSession(),
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
                        onTap: () => showBottomSheet(ExerciseContext.add))))
          ],
        ),
      ),
    );
  }

  CustomTextField buildNotesTextField() {
    return CustomTextField(
        hint: Strings.generalNotesHint,
        controller: _editNotesController,
        focusNode: _notesFocusNode,
        primaryColor: AppColor.getPplColor(_type),
        onChanged: (newValue) {
          setState(() {
            _notesText = newValue;
          });
        });
  }

  Widget buildCopyPreviousSession() {
    BlocProvider.of<SessionsBloc>(context).add(FetchLastSessionOfType(_type));
    return BlocBuilder<SessionsBloc, SessionsState>(
      buildWhen: (p, c) => c is LastSessionOfTypeState,
      builder: (context, state) {
        if (state is LastSessionOfTypeState) {
          final lastSession = state.lastSession;
          if (lastSession != null &&
              !_lastSessionCopied &&
              _editArgs.session == null) {
            return Column(
              children: [
                const SizedBox(height: 16),
                AccentButton(
                    text: Strings.copyLastSession(_type.toSessionString()),
                    onTap: () => copyLastSession(lastSession)),
              ],
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  copyLastSession(Session lastSession) {
    _lastSessionCopied = true;
    _newExerciseCount = 0;
    _exerciseMap = {};
    for (var exercise in lastSession.exercises) {
      onNewExercise(exercise);
    }
  }

  void showBottomSheet(ExerciseContext addEditContext,
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

  ExerciseBottomSheet exerciseBottomSheet(ExerciseContext addEditContext,
      Exercise? exerciseToEdit, int? keyToEdit) {
    return ExerciseBottomSheet(
        addEditContext: addEditContext,
        sessionType: _type,
        previousExercise: exerciseToEdit,
        onDeleteExercise: () {
          if (addEditContext == ExerciseContext.edit) {
            if (keyToEdit != null) {
              onDeletedExercise(keyToEdit);
            }
          }
        },
        onSubmitExercise: (newExercise) {
          if (addEditContext == ExerciseContext.add) {
            onNewExercise(newExercise);
          } else {
            if (keyToEdit != null) {
              onUpdatedExercise(keyToEdit, newExercise);
            }
          }
        });
  }

  void onNewExercise(Exercise exercise) {
    _newExerciseCount++;
    setState(() {
      _exerciseMap[_newExerciseCount] = exercise;
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
    showBottomSheet(ExerciseContext.edit, exercise, key);
  }

  void populateWithSessionToEdit(Session session) {
    _notesText = session.notes;
    _type = session.type;
    _newExerciseCount = 0;
    for (var ex in session.exercises) {
      onNewExercise(ex);
    }
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
