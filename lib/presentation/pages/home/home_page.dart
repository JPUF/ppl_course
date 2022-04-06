import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:ppl_course/presentation/pages/home/placeholder_session_widget.dart';
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

    const cycleNumber = 0;

    final sessionBuilder = BlocBuilder<CyclesBloc, Response<CyclesState>>(
        builder: (context, state) {
      final data = state.data;
      if (state.status == Status.completed && data is AllCyclesState) {
        return Column(
          children: data.cycles[cycleNumber].sessions
              .map((session) => GestureDetector(
                    child: SessionWidget(session: session),
                    onTap: () {
                      Navigator.of(context).pushNamed(Destination.exercise,
                          arguments:
                              SessionArgs(cycleNumber, session.sessionNumber));
                    },
                  ))
              .toList(),
        );
      } else {
        return const SizedBox(height: 16);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const PlaceholderSession(),
                      const SizedBox(height: 16),
                      sessionBuilder,
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColor.accent,
                child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 30),
                    onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
