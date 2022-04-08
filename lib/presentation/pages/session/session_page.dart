import 'package:flutter/material.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import 'components/add_exercise.dart';
import 'components/ppl_selector_switch.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TextEditingController _editingController;
  late FocusNode _notesFocusNode;
  String _notesText = "";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: _notesText);
    _notesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.planSessionTitle,
            style: AppTextStyles.button.apply(color: AppColor.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const PplSelectorSwitch(),
                        const SizedBox(height: 32),
                        notesTextField()
                      ],
                    ),
                  ),
                ),
              ),
              const AddExercise()
            ],
          ),
        ),
      ),
    );
  }

  Center notesTextField() {
    return Center(
      child: TextField(
        focusNode: _notesFocusNode,
        onTap: () {
          setState(() {
            FocusScope.of(context).requestFocus(_notesFocusNode);
          });
        },
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 4,
        style: AppTextStyles.body15.apply(color: _notesFocusNode.hasFocus ? AppColor.black : AppColor.grey50),
        cursorColor: AppColor.dark,
        decoration: InputDecoration(
            labelText: Strings.generalNotesHint,
            floatingLabelStyle: AppTextStyles.body12.apply(
                color:
                    _notesFocusNode.hasFocus ? AppColor.dark : AppColor.grey75),
            labelStyle: AppTextStyles.body12.apply(color: AppColor.grey75),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColor.grey75),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColor.dark),
                borderRadius: BorderRadius.circular(8))),
        onSubmitted: (newValue) {
          setState(() {
            _notesText = newValue;
          });
        },
        autofocus: false,
        controller: _editingController,
      ),
    );
  }
}
