import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueSetter<String> onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: TextField(
          focusNode: widget.focusNode,
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(widget.focusNode);
            });
          },
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 4,
          style: AppTextStyles.body15.apply(
              color:
                  widget.focusNode.hasFocus ? AppColor.black : AppColor.grey50),
          cursorColor: AppColor.dark,
          decoration: InputDecoration(
              labelText: Strings.generalNotesHint,
              floatingLabelStyle: AppTextStyles.body12.apply(
                  color: widget.focusNode.hasFocus
                      ? AppColor.dark
                      : AppColor.grey75),
              labelStyle: AppTextStyles.body12.apply(color: AppColor.grey75),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColor.grey75),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColor.dark),
                  borderRadius: BorderRadius.circular(8))),
          onChanged: (newValue) {
            setState(() => widget.onChanged(newValue));
          },
          autofocus: false,
          controller: widget.controller,
        ),
      ),
    );
  }
}
