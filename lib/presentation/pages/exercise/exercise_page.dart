import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    final SessionArgs args =
        ModalRoute.of(context)?.settings.arguments as SessionArgs;

    BlocProvider.of<CyclesBloc>(context).add(FetchSession(args));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("${args.cycleNumber} – ${args.sessionNumber}",
                  style: Theme.of(context).textTheme.headline3)
            ],
          ),
        ),
      ),
    );
  }
}
