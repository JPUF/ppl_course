import 'package:flutter/material.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Text("Deadlift",
                  style: Theme.of(context).textTheme.bodyText1)),
          Expanded(
              flex: 2,
              child:
                  Text("1x5+", style: Theme.of(context).textTheme.bodyText1)),
          Expanded(
              flex: 1,
              child: Text("170kg", style: Theme.of(context).textTheme.bodyText1))
        ],
      ),
    );
  }
}
