import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';

class PlaceholderWidget extends StatefulWidget {
  const PlaceholderWidget({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  State<PlaceholderWidget> createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                widget.text,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
          )),
      onTap: widget.onTap,
    );
  }
}
