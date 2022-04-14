import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class AccentButton extends StatelessWidget {
  const AccentButton(
      {Key? key,
      required this.text,
      this.isEnabled = true,
      required this.onTap,
      this.endIcon})
      : super(key: key);

  final String text;
  final bool isEnabled;
  final VoidCallback onTap;
  final SvgPicture? endIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: isEnabled ? AppColor.accent : AppColor.grey90,
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isEnabled ? AppColor.black : AppColor.grey75 , width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.button.apply(
                    color: isEnabled ? AppColor.black : AppColor.grey75
                  ),
                ),
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
