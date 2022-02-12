import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/cycle/cycle.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                BlocBuilder<CyclesBloc, Response<CyclesState>>(
                    builder: (context, state) {
                  switch (state.status) {
                    case Status.completed:
                      final List<Session>? sessions = state.data?.cycles[0].sessions;
                      if (sessions != null) {
                        return Column(
                          children: sessions.map((session) => SessionWidget(session: session)).toList(),
                        );
                        for (var session in sessions) {
                          return Column(
                            children: [
                              SessionWidget(session: session),
                              const SizedBox(height: 16)
                            ],
                          );
                        }
                      }
                      return const SizedBox(height: 16);
                    default:
                      return const SizedBox(height: 16);
                  }
                }),
                const SizedBox(height: 16),
                FloatingActionButton(
                  heroTag: 'routeCta',
                  backgroundColor: AppColor.accent,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Destination.second);
                  },
                  child: const Icon(Icons.navigate_next_rounded),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
