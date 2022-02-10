import 'package:flutter/material.dart';
import 'package:ppl_course/presentation/pages/home/exercise_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.secondary, borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text("1", style: Theme.of(context).textTheme.headline3),
                const SizedBox(width: 16),
                Text("Pull", style: Theme.of(context).textTheme.headline4)
              ],
            ),
          ),
          Divider(color: AppColor.dark, thickness: 2),
          const SizedBox(height: 8),
          const ExerciseWidget(),
          Divider(color: AppColor.dark, thickness: 1),
          const ExerciseWidget(),
          Divider(color: AppColor.dark, thickness: 1),
          const ExerciseWidget(),
          Divider(color: AppColor.dark, thickness: 1),
          const ExerciseWidget(),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
