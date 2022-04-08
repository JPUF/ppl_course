import 'package:flutter/material.dart';

class AddExerciseBottomSheet extends StatelessWidget {
  const AddExerciseBottomSheet({Key? key, required this.onDismiss})
      : super(key: key);

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("text"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDismiss();
                },
                child: const Text("button"))
          ],
        ));
  }
}
