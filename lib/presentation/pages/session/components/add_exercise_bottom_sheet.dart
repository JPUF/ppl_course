import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/data/models/exercise/weight.dart';
import 'package:ppl_course/presentation/pages/session/components/set_rep_slider.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AddExerciseBottomSheet extends StatefulWidget {
  const AddExerciseBottomSheet({Key? key, required this.addExercise})
      : super(key: key);

  final ValueSetter<Exercise> addExercise;

  @override
  State<AddExerciseBottomSheet> createState() => _AddExerciseBottomSheetState();
}

class _AddExerciseBottomSheetState extends State<AddExerciseBottomSheet> {
  final ItemScrollController _scrollController = ItemScrollController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _weightFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();
  String _nameText = "";
  String _weightText = "";
  String? _notesText;
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _notesController;

  late List<Widget> _contentList;

  int _setCount = 1;
  int _repCount = 1;

  bool _amrapFinal = false;

  bool _isValidExercise = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _nameText);
    _weightController = TextEditingController(text: _weightText);
    _notesController = TextEditingController(text: _notesText);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _contentList = buildContentWidgetList();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => unfocusAll(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemCount: _contentList.length,
            itemBuilder: (_, index) => _contentList[index]),
      ),
    );
  }

  void unfocusAll() => FocusManager.instance.primaryFocus?.unfocus();

  List<Widget> buildContentWidgetList() {
    return [
      buildNameWeightRow(),
      SetRepSlider(
          label: Strings.exerciseSetLabel,
          max: 8,
          onTap: () => unfocusAll(),
          onChanged: (newValue) {
            setState(() => _setCount = newValue);
          }),
      const SizedBox(height: 32),
      SetRepSlider(
          label: Strings.exerciseRepLabel,
          max: 20,
          onTap: () => unfocusAll(),
          onChanged: (newValue) {
            setState(() => _repCount = newValue);
          }),
      const SizedBox(height: 16),
      buildAmrapRow(),
      const SizedBox(height: 16),
      CustomTextField(
          hint: Strings.exerciseNotesHint,
          controller: _notesController,
          focusNode: _notesFocusNode,
          keyboardType: TextInputType.multiline,
          onTap: () => scrollToNotes(),
          onChanged: (newValue) {
            setState(() {
              _notesText = newValue;
              if (newValue.isEmpty) {
                _notesText = null;
              }
            });
          }),
      const SizedBox(height: 32),
      AccentButton(
          text: Strings.addExerciseCTA,
          isEnabled: _isValidExercise,
          onTap: () => addNewExercise()),
      const SizedBox(height: 400),
    ];
  }

  void checkExerciseValidity() {
    setState(() {
      _isValidExercise = _nameText.isNotEmpty && _weightText.isNotEmpty;
    });
  }

  Row buildAmrapRow() {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 3,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.only(left: 4),
                title: Text(
                  Strings.exerciseAmrapLabel,
                  style: AppTextStyles.body12.apply(color: AppColor.black),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: _amrapFinal,
                activeColor: AppColor.dark,
                dense: true,
                onChanged: (newValue) {
                  setState(() {
                    _amrapFinal = newValue ?? false;
                  });
                });
          }),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget buildNameWeightRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                hint: Strings.exerciseNameHint,
                controller: _nameController,
                focusNode: _nameFocusNode,
                keyboardType: TextInputType.multiline,
                onChanged: (newValue) {
                  setState(() {
                    _nameText = newValue;
                    checkExerciseValidity();
                  });
                }),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: CustomTextField(
                hint: Strings.exerciseWeightHint,
                controller: _weightController,
                focusNode: _weightFocusNode,
                keyboardType: TextInputType.number,
                maxLength: 3,
                onChanged: (newValue) {
                  setState(() {
                    _weightText = newValue;
                    checkExerciseValidity();
                  });
                }),
          )
        ],
      ),
    );
  }

  void scrollToNotes() {
    _scrollController.scrollTo(
        index: 6,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 750));
  }

  void addNewExercise() {
    final setReps =
        SetsReps(sets: _setCount, reps: _repCount, amrapFinalSet: _amrapFinal);
    final weight = Weight(double.parse(_weightText));
    final exercise = Exercise.weighted(
        name: _nameText, setsReps: setReps, weight: weight, notes: _notesText);
    widget.addExercise(exercise);
    dismissBottomSheet();
  }

  void dismissBottomSheet() => Navigator.pop(context);
}
