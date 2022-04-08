import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';

class AddExercise extends StatelessWidget {
  const AddExercise({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: PhysicalModel(
        elevation: 8,
        shadowColor: AppColor.black,
        color: AppColor.accent,
        shape: BoxShape.circle,
        child: CircleAvatar(
          backgroundColor: AppColor.accent,
          radius: 32.0,
          child: Icon(
            Icons.add,
            color: AppColor.white,
            size: 48.0,
          ),
        ),
      ),
    );
  }
}
