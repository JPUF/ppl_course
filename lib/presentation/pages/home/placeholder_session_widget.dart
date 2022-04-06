import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';

class PlaceholderSession extends StatelessWidget {
  const PlaceholderSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.light,
              border: Border.all(color: AppColor.dark),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Plan your first workout session by tapping +',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
