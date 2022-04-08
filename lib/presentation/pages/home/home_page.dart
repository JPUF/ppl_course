import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/presentation/pages/home/components/session_widget.dart';
import 'package:ppl_course/res/string/strings.dart';

import 'components/home_header.dart';

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
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const HomeHeader(),
                        const SizedBox(height: 16),
                        sessionBuilder,
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AccentButton(
              text: Strings.planSessionCTA,
              onTap: () => Navigator.of(context).pushNamed(Destination.session),
              endIcon: SvgPicture.asset(
                'assets/images/ic_weight.svg',
                width: 24,
                height: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
