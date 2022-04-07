import 'package:flutter/material.dart';
import 'package:ppl_course/presentation/pages/home/placeholder_widget.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PlaceholderWidget(text: "Add an exercise", onTap: () {

              })
            ],
          ),
        ),
      ),
    );
  }
}
