import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class PplSelectorSwitch extends StatefulWidget {
  const PplSelectorSwitch(
      {Key? key, required this.initialType, required this.onChanged})
      : super(key: key);

  final SessionType initialType;
  final ValueSetter<SessionType> onChanged;

  @override
  State<PplSelectorSwitch> createState() => _PplSelectorSwitchState();
}

class _PplSelectorSwitchState extends State<PplSelectorSwitch> {
  int value = 0;
  bool initialTypeSet = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setInitialType();
    });
    return PhysicalModel(
      elevation: 4,
      color: AppColor.transparent,
      shadowColor: AppColor.black,
      child: AnimatedToggleSwitch<int>.size(
        current: value,
        values: const [0, 1, 2],
        iconOpacity: 0.25,
        animationDuration: const Duration(milliseconds: 300),
        indicatorSize: const Size.fromWidth(100),
        customIconBuilder: (context, local, global) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconBuilder(context, local, global),
            ],
          );
        },
        borderColor: pplColorFromIndex(value),
        borderWidth: 2,
        indicatorBorderRadius: BorderRadius.zero,
        borderRadius: BorderRadius.circular(8),
        colorBuilder: (i) => pplColorFromIndex(value).shade50,
        onChanged: (i) {
          setState(() {
            value = i;
            widget.onChanged(SessionType.values[i]);
          });
        },
      ),
    );
  }

  Widget iconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    String pplString = Strings.push;
    MaterialAppColor pplColor = pplColorFromIndex(local.value);
    switch (local.value) {
      case 0:
        pplString = Strings.push;
        break;
      case 1:
        pplString = Strings.pull;
        break;
      case 2:
        pplString = Strings.legs;
        break;
    }
    return Text(
      pplString,
      style: AppTextStyles.headline3.apply(color: pplColor),
    );
  }

  void setInitialType() {
    if (!initialTypeSet) {
      value = widget.initialType.index;
      widget.onChanged(SessionType.values[widget.initialType.index]);
    }
    initialTypeSet = true;
  }

  MaterialAppColor pplColorFromIndex(int index) {
    switch (index) {
      case 0:
        return AppColor.push;
      case 1:
        return AppColor.pull;
      case 2:
        return AppColor.legs;
      default:
        return AppColor.push;
    }
  }
}
