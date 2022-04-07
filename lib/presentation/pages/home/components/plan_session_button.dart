import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class PlanSessionButton extends StatelessWidget {
  const PlanSessionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Destination.session);
      },
      child: Card(
        color: AppColor.accent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 16, right: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Strings.planSessionCTA,
                textAlign: TextAlign.center,
                style: AppTextStyles.button,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/images/ic_weight.svg',
                width: 24,
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
