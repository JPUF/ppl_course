import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/presentation/pages/session/components/set_rep_slider.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AddExerciseBottomSheet extends StatefulWidget {
  const AddExerciseBottomSheet({Key? key}) : super(key: key);

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
  String _notesText = "";
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _notesController;

  late List<Widget> _contentList;

  int _setCount = 1;
  int _repCount = 1;

  bool _amrapFinal = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _nameText);
    _weightController = TextEditingController(text: _weightText);
    _notesController = TextEditingController(text: _notesText);
    _contentList = buildContentWidgetList();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ScrollablePositionedList.builder(
          itemScrollController: _scrollController,
          itemCount: _contentList.length,
          itemBuilder: (_, index) => _contentList[index]),
    );
  }

  List<Widget> buildContentWidgetList() {
    return [
      buildNameWeightRow(),
      SetRepSlider(
          label: Strings.activitySetLabel,
          max: 8,
          onChanged: (newValue) {
            setState(() => _setCount = newValue);
          }),
      const SizedBox(height: 16),
      SetRepSlider(
          label: Strings.activityRepLabel,
          max: 20,
          onChanged: (newValue) {
            setState(() => _setCount = newValue);
          }),
      buildAmrapRow(),
      CustomTextField(
          hint: Strings.activityNotesHint,
          controller: _notesController,
          focusNode: _notesFocusNode,
          keyboardType: TextInputType.multiline,
          onTap: () => scrollToNotes(),
          onChanged: (newValue) {}),
      const SizedBox(height: 32),
      AccentButton(
          text: Strings.addActivityCTA, onTap: () => dismissBottomSheet()),
      const SizedBox(height: 500),
    ];
  }

  Row buildAmrapRow() {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 3,
          child: CheckboxListTile(
              contentPadding: const EdgeInsets.only(left: 4),
              title: Text(
                Strings.activityAmrapLabel,
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
              }),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget buildNameWeightRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                hint: Strings.activityNameHint,
                controller: _nameController,
                focusNode: _nameFocusNode,
                keyboardType: TextInputType.multiline,
                onChanged: (newValue) {}),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: CustomTextField(
                hint: Strings.activityWeightHint,
                controller: _weightController,
                focusNode: _weightFocusNode,
                keyboardType: TextInputType.number,
                onChanged: (newValue) {}),
          )
        ],
      ),
    );
  }

  void scrollToNotes() {
    _scrollController.scrollTo(
        index: 5,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 750));
  }

  void dismissBottomSheet() => Navigator.pop(context);
}
