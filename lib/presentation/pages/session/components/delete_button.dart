import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.accent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.delete,
            color: AppColor.accent,
          ),
        ),
      ),
    );
  }
}
