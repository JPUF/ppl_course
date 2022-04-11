import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/presentation/pages/session/components/set_rep_slider.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class AddExerciseBottomSheet extends StatefulWidget {
  const AddExerciseBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddExerciseBottomSheet> createState() => _AddExerciseBottomSheetState();
}

class _AddExerciseBottomSheetState extends State<AddExerciseBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late FocusNode _nameFocusNode;
  late FocusNode _weightFocusNode;
  String _nameText = "";
  String _weightText = "";

  int _setCount = 1;
  int _repCount = 1;

  bool _amrapFinal = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _nameText);
    _weightController = TextEditingController(text: _weightText);
    _nameFocusNode = FocusNode();
    _weightFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 510,
        child: Column(
          children: [
            buildSheetHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  buildNameWeightRow(),
                  SetRepSlider(
                      label: Strings.activitySetLabel,
                      max: 8,
                      onChanged: (newValue) {
                        setState(() => _setCount = newValue);
                      }),
                  SetRepSlider(
                      label: Strings.activityRepLabel,
                      max: 20,
                      onChanged: (newValue) {
                        setState(() => _setCount = newValue);
                      }),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                            contentPadding: const EdgeInsets.only(left: 4),
                            title: Text(
                              Strings.activityAmrapLabel,
                              style: AppTextStyles.body12,
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
                  ),
                  const SizedBox(height: 48),
                  AccentButton(
                      text: Strings.addActivityCTA,
                      onTap: () => dismissBottomSheet())
                ],
              ),
            ),
          ],
        ));
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

  Align buildSheetHeader() {
    return Align(
        alignment: Alignment.centerRight,
        child: MaterialButton(
          onPressed: () => dismissBottomSheet(),
          minWidth: 0,
          height: 0,
          child: Icon(
            Icons.close,
            color: AppColor.black,
            size: 20,
          ),
        ));
  }

  void dismissBottomSheet() => Navigator.pop(context);
}
