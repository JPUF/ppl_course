import 'package:flutter/material.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SetRepSlider extends StatefulWidget {
  const SetRepSlider(
      {Key? key,
      required this.label,
      required this.max,
      required this.onChanged})
      : super(key: key);

  final String label;
  final int max;
  final ValueSetter<int> onChanged;

  @override
  State<SetRepSlider> createState() => _SetRepSliderState();
}

class _SetRepSliderState extends State<SetRepSlider> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: AppTextStyles.body12,
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Text("$_value",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline3)),
            Expanded(
              flex: 8,
              child: SfSlider(
                min: 1,
                max: widget.max,
                value: _value,
                interval: 1,
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
        const SizedBox(height: 16)
      ],
    );
  }
}
