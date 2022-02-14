import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:ppl_course/presentation/pages/home/session_widget.dart';
import 'package:ppl_course/res/color/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CyclesBloc>(context).add(FetchCycles());

    final sessionBuilder = BlocBuilder<CyclesBloc, Response<CyclesState>>(
        builder: (context, state) {
      if (state.status != Status.completed) return const SizedBox(height: 16);

      final List<Session>? sessions = state.data?.cycles[0].sessions;
      if (sessions == null) return const SizedBox(height: 16);
      return Column(
        children: sessions
            .map((session) => GestureDetector(
                  child: SessionWidget(session: session),
                  onTap: () {
                    Navigator.of(context).pushNamed(Destination.exercise);
                  },
                ))
            .toList(),
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16),
                  sessionBuilder,
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
