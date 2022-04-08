import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class AccentButton extends StatelessWidget {
  const AccentButton(
      {Key? key, required this.text, required this.onTap, this.endIcon})
      : super(key: key);

  final String text;
  final VoidCallback onTap;
  final SvgPicture? endIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
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
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.button,
              ),
              _optionalEndIcon()
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionalEndIcon() {
    final icon = endIcon;
    if (icon == null) return Container();
    return Row(children: [const SizedBox(width: 8), icon]);
  }
}
