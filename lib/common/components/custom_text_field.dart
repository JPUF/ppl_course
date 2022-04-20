import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.focusNode,
      this.primaryColor,
      this.keyboardType,
      this.maxLength,
      this.onTap,
      required this.onChanged})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final MaterialColor? primaryColor;
  final TextInputType? keyboardType;
  final int? maxLength;
  final VoidCallback? onTap;
  final ValueSetter<String> onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final MaterialColor _primaryColor = widget.primaryColor ?? AppColor.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
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
          inputFormatters: getInputFormatter(),
          minLines: 1,
          maxLines: 4,
          style: AppTextStyles.body15.apply(
              color:
                  widget.focusNode.hasFocus ? AppColor.black : AppColor.grey50),
          cursorColor: _primaryColor,
          decoration: InputDecoration(
              labelText: widget.hint,
              floatingLabelStyle: AppTextStyles.body12.apply(
                  color: widget.focusNode.hasFocus
                      ? _primaryColor
                      : AppColor.grey75),
              labelStyle: AppTextStyles.body12.apply(color: AppColor.grey75),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColor.grey75),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: _primaryColor),
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

  List<TextInputFormatter> getInputFormatter() {
    if (widget.keyboardType == TextInputType.number) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(widget.maxLength)
      ];
    }
    return [];
  }
}
