import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.focusNode,
      this.keyboardType,
      this.onTap,
      required this.onChanged})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
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
            widget.onTap?.call();
          },
          keyboardType: widget.keyboardType ?? TextInputType.text,
          minLines: 1,
          maxLines: 4,
          style: AppTextStyles.body15.apply(
              color:
                  widget.focusNode.hasFocus ? AppColor.black : AppColor.grey50),
          cursorColor: AppColor.dark,
          decoration: InputDecoration(
              labelText: widget.hint,
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
