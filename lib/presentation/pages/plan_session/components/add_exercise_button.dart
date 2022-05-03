import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:ppl_course/res/color/colors.dart';

class AddExerciseButton extends StatelessWidget {
  const AddExerciseButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Material(
        elevation: 4.0,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: AppColor.accent,
        child: Ink.image(
          image: const Svg('assets/images/ic_plus.svg', size: Size(32, 32)),
          width: 48,
          height: 48,
          child: InkWell(
            onTap: () => onTap(),
          ),
        ),
      ),
    );
  }
}
