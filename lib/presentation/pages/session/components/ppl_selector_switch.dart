import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class PplSelectorSwitch extends StatelessWidget {
  const PplSelectorSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    //     child: AnimatedToggleSwitch<int>.size(
    //   textDirection: TextDirection.rtl,
    //   current: 1,
    //   values: const [0, 1, 2, 3],
    //   iconOpacity: 0.2,
    //   indicatorSize: const Size.fromWidth(100),
    //   customIconBuilder: (context, local, global) {
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('${local.value}'),
    //         alternativeIconBuilder(context, local, global),
    //       ],
    //     );
    //   },
    //   borderColor: value.isEven ? Colors.blue : Colors.red,
    //   colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
    //   onChanged: (i) => setState(() => value = i),
    // ), ,
    );
  }

  Widget alternativeIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    IconData data = Icons.access_time_rounded;
    switch (local.value) {
      case 0:
        data = Icons.ac_unit_outlined;
        break;
      case 1:
        data = Icons.account_circle_outlined;
        break;
      case 2:
        data = Icons.assistant_navigation;
        break;
      case 3:
        data = Icons.arrow_drop_down_circle_outlined;
        break;
    }
    return Icon(
      data,
      size: local.iconSize.shortestSide,
    );
  }
}
