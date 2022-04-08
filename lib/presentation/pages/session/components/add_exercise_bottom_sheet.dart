import 'package:flutter/material.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';

class AddExerciseBottomSheet extends StatefulWidget {
  const AddExerciseBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddExerciseBottomSheet> createState() => _AddExerciseBottomSheetState();
}

class _AddExerciseBottomSheetState extends State<AddExerciseBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 510,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: const CircleBorder(side: BorderSide(width: 2)),
                    primary: AppColor.white,
                  ),
                  onPressed: () => dismissBottomSheet(),
                  child: Icon(
                    Icons.close,
                    color: AppColor.black,
                    size: 32,
                  ),
                )),
            AccentButton(text: Strings.addActivityCTA,
                onTap: () => dismissBottomSheet())
          ],
        ));
  }

  void dismissBottomSheet() => Navigator.pop(context);
}
