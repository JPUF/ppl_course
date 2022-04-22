import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SetRepSlider extends StatefulWidget {
  const SetRepSlider(
      {Key? key,
      required this.label,
      required this.max,
      this.initialValue,
      required this.primaryColor,
      this.onTap,
      required this.onChanged})
      : super(key: key);

  final String label;
  final int max;
  final int? initialValue;
  final MaterialColor primaryColor;
  final VoidCallback? onTap;
  final ValueSetter<int> onChanged;

  @override
  State<SetRepSlider> createState() => _SetRepSliderState();
}

class _SetRepSliderState extends State<SetRepSlider> {
  int _value = 1;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: AppTextStyles.body14.apply(color: AppColor.black),
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("$_value",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headline3
                          .apply(color: widget.primaryColor))),
              Expanded(
                flex: 8,
                child: SfSlider(
                  min: 1,
                  max: widget.max,
                  value: _value,
                  interval: 1,
                  activeColor: widget.primaryColor,
                  showTicks: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value.toInt();
                      widget.onChanged(value.toInt());
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
