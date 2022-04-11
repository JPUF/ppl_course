import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/common/components/custom_text_field.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';

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
                  AccentButton(
                      text: Strings.addActivityCTA,
                      onTap: () => dismissBottomSheet())
                ],
              ),
            ),
          ],
        ));
  }

  Row buildNameWeightRow() {
    return Row(
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
