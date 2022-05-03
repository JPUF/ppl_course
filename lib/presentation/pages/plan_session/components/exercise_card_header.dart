import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppl_course/data/models/exercise/exercise.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class ExerciseCardHeader extends StatefulWidget {
  const ExerciseCardHeader(
      {Key? key, required this.exercise, required this.pplColor})
      : super(key: key);

  final MaterialColor pplColor;
  final Exercise exercise;

  @override
  State<ExerciseCardHeader> createState() => _ExerciseCardHeaderState();
}

class _ExerciseCardHeaderState extends State<ExerciseCardHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 8,
            child: Align(
              alignment: Alignment.center,
              child: Text(widget.exercise.name,
                  style: AppTextStyles.headline4.apply(color: widget.pplColor)),
            )),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              buildWeight(widget.pplColor),
              const SizedBox(height: 8),
              buildSetReps(widget.pplColor)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildWeight(MaterialColor pplColor) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/ic_generic_weight.svg',
          width: 12,
          height: 12,
          color: pplColor,
        ),
        const SizedBox(width: 6),
        Text(widget.exercise.weight?.toString() ?? 'N/A',
            style: AppTextStyles.button.apply(color: pplColor)),
      ],
    );
  }

  Widget buildSetReps(MaterialColor pplColor) {
    return Row(
      children: [
        Icon(
          Icons.repeat,
          size: 16,
          color: pplColor,
        ),
        const SizedBox(width: 4),
        Text(widget.exercise.setsReps.toString(),
            style: AppTextStyles.button.apply(color: pplColor)),
      ],
    );
  }
}
