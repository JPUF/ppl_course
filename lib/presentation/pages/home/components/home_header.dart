import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Strings.push,
                style: AppTextStyles.headline2.apply(color: AppColor.push)),
            Text(Strings.pull,
                style: AppTextStyles.headline2.apply(color: AppColor.pull)),
            Text(Strings.legs,
                style: AppTextStyles.headline2.apply(color: AppColor.legs)),
          ],
        ),
        Text(Strings.planner,
            style: AppTextStyles.headline2.apply(color: AppColor.pull)),
      ],
    );
  }
}
