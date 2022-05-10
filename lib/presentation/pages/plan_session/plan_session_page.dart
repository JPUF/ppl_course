import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/common/utils/date_time_day.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/add_exercise_button.dart';
import 'components/bottom_sheet_header.dart';
import 'components/delete_button.dart';
import 'components/exercise_bottom_sheet.dart';
import 'components/plan_exercise_widget.dart';
import 'components/ppl_selector_switch.dart';

class PlanSessionPage extends StatefulWidget {
  const PlanSessionPage(
      {Key? key, required this.setNavBarVisibility, this.sessionToEdit})
      : super(key: key);
  final ValueSetter<bool> setNavBarVisibility;
  final Session? sessionToEdit;

  @override
  _PlanSessionPageState createState() => _PlanSessionPageState();
}

class _PlanSessionPageState extends State<PlanSessionPage> {
  late TextEditingController _editNotesController;
  late FocusNode _notesFocusNode;

  SessionType _type = SessionType.push;
  String? _notesText;

  bool _lastSessionCopied = false;

  Map<int, Exercise> _exerciseMap = {};
  int _newExerciseCount = 0;

  bool _editSessionPopulated = false;

  bool _hasSessionToEdit() => widget.sessionToEdit != null;

  late DateTimeDay _selectedDay;
  late final DateTimeDay _dateToday;
  late final DateTimeDay _dateTomorrow;
  final List<DateTimeDay> _otherDayOptions = [];
  late DateTimeDay _dateOther;

  late MaterialColor _pplColor;

  late List<bool> _dayOptions;

  List<bool> _setDaySelection(int index) {
    switch (index) {
      case 0:
        _selectedDay = _dateToday;
        break;
      case 1:
        _selectedDay = _dateTomorrow;
        break;
      case 2:
        _selectedDay = _dateOther;
        break;
    }
    return List.generate(3, (i) => (i == index));
  }

  @override
  void initState() {
    super.initState();
    _editNotesController = TextEditingController(text: _notesText);
    _notesFocusNode = FocusNode();
    _pplColor = AppColor.getPplColor(_type);
    final now = DateTime.now();
    _dateToday = DateTimeDay(now.year, now.month, now.day);
    _dateTomorrow =
        DateTimeDay.fromDateTime(_dateToday.add(const Duration(days: 1)));
    _dateOther =
        DateTimeDay.fromDateTime(_dateTomorrow.add(const Duration(days: 1)));
    _dayOptions = _setDaySelection(0);
    initOtherDayOptions();
  }

  PplSelectorSwitch buildPplSwitch(SessionType type) {
    return PplSelectorSwitch(
        initialType: type,
        onChanged: (newType) {
          setState(() {
            _lastSessionCopied = false;
            _type = newType;
            _pplColor = AppColor.getPplColor(newType);
            _clearExercises();
          });
        });
  }

  void initOtherDayOptions() {
    for (int i = 1; i <= 5; i++) {
      _otherDayOptions
          .add(DateTimeDay.fromDateTime(_dateTomorrow.add(Duration(days: i))));
    }
  }

  @override
  void dispose() {
    _editNotesController.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionToEdit = widget.sessionToEdit;
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
                    buildPplSwitch(_type),
                    const SizedBox(height: 32),
                    buildSelectDay(),
                    const SizedBox(height: 16),
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
                        onTap: () => showBottomSheet(ExerciseContext.add)))),
            buildDeleteButton()
          ],
        ),
      ),
    );
  }

  Widget buildSelectDay() {
    return PhysicalModel(
      elevation: 2,
      color: AppColor.white,
      shadowColor: AppColor.black,
      borderRadius: BorderRadius.circular(8),
      child: ToggleButtons(
        children: [
          dayButton(Strings.planToday, false),
          dayButton(Strings.planTomorrow, false),
          dayButton(_dateOther.toString(), true),
        ],
        isSelected: _dayOptions,
        fillColor: _pplColor.shade50,
        borderColor: _pplColor,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(8),
        selectedBorderColor: _pplColor,
        onPressed: (int index) {
          setState(() {
            _dayOptions = _setDaySelection(index);
            if (index == 2) {
              showDayDialog();
            }
          });
        },
      ),
    );
  }

  void showDayDialog() {
    showMaterialScrollPicker<DateTimeDay>(
        context: context,
        title: Strings.planDayDialogTitle,
        items: _otherDayOptions,
        selectedItem: _dateOther,
        onChanged: (day) {
          setState(() {
            _dateOther = day;
            _selectedDay = day;
            _dayOptions = [false, false, true];
          });
        });
  }

  Widget dayButton(String text, bool editIcon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(text, style: AppTextStyles.body17.apply(color: _pplColor)),
          editIcon ? const SizedBox(width: 8) : Container(),
          editIcon ? Icon(Icons.edit_outlined, color: _pplColor) : Container()
        ],
      ),
    );
  }

  Widget buildDeleteButton() {
    if (_hasSessionToEdit()) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Align(
              alignment: Alignment.bottomRight,
              child: DeleteButton(onTap: () => deleteSession())));
    }
    return Container();
  }

  CustomTextField buildNotesTextField() {
    return CustomTextField(
        hint: Strings.generalNotesHint,
        initialText: _notesText,
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
              !_hasSessionToEdit()) {
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
    widget.setNavBarVisibility(false);
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
        }).whenComplete(() {
      widget.setNavBarVisibility(true);
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
    if (!_editSessionPopulated) {
      _notesText = session.notes;
      _type = session.type;
      _newExerciseCount = 0;
      for (var ex in session.exercises) {
        onNewExercise(ex);
      }
    }
    _editSessionPopulated = true;
  }

  void submitSession() {
    String? notes = _notesText;
    if (notes != null) {
      if (notes.isEmpty) {
        notes = null;
      }
    }
    final editSession = widget.sessionToEdit;
    if (_exerciseMap.isNotEmpty) {
      if (editSession == null) {
        final session = Session(
            _type, _selectedDay, _notesText, _exerciseMap.values.toList());
        BlocProvider.of<SessionsBloc>(context).add(WriteSession(session));
      } else {
        final session = constructSession(editSession);
        BlocProvider.of<SessionsBloc>(context).add(EditSession(session));
      }
    }
    navigateToHome();
  }

  deleteSession() {
    final editSession = widget.sessionToEdit;
    if (editSession != null) {
      BlocProvider.of<SessionsBloc>(context)
          .add(DeleteSession(constructSession(editSession)));
    }
    navigateToHome();
  }

  Session constructSession(Session editSession) {
    return Session.withUuid(
      uuid: editSession.uuid,
      type: _type,
      day: _selectedDay,
      notes: _notesText,
      exercises: _exerciseMap.values.toList(),
    );
  }

  void _clearExercises() {
    _exerciseMap = {};
    _newExerciseCount = 0;
  }

  void navigateToHome() {
    Navigator.pop(context);
  }
}
