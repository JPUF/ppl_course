import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
}