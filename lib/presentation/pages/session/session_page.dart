import 'package:flutter/material.dart';
import 'package:ppl_course/presentation/pages/home/components/placeholder_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

import 'components/ppl_selector_switch.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      PplSelectorSwitch()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: PhysicalModel(
                elevation: 8,
                shadowColor: AppColor.dark,
                color: AppColor.accent,
                shape: BoxShape.circle,
                child: CircleAvatar(
                  backgroundColor: AppColor.accent,
                  radius: 32.0,
                  child: Icon(
                    Icons.add,
                    color: AppColor.white,
                    size: 48.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}