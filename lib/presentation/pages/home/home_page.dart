import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ppl_course/common/components/asset_button.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/navigation/destination.dart';
import 'package:ppl_course/presentation/pages/home/components/session_widget.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

import '../plan_session/session_args.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final BlocBuilder<SessionsBloc, SessionsState> sessionBuilder;

  @override
  void initState() {
    super.initState();
    sessionBuilder = BlocBuilder<SessionsBloc, SessionsState>(
        buildWhen: (p, c) => c is AllSessionsState,
        builder: (context, state) {
          if (state is AllSessionsState) {
            final sessions = state.allSessions;
            return Container(
                padding: const EdgeInsets.only(bottom: 64),
                child: Column(
                  children: sessions
                      .map((session) => GestureDetector(
                            onTap: () => onTapLogSession(session),
                            child: SessionWidget(
                                session: session,
                                onTappedLog: () => onTapLogSession(session),
                                onTappedEdit: () => onTapEditSession(session)),
                          ))
                      .toList(),
                ));
          } else {
            return const SizedBox(height: 16);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.appTitle, style: AppTextStyles.barTitle),
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [buildHomePageContent(), buildPlanSessionButton(context)],
        ),
      ),
    );
  }

  SizedBox buildHomePageContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                sessionBuilder,
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPlanSessionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: AccentButton(
        text: Strings.planSessionCTA,
        onTap: () => Navigator.of(context)
            .pushNamed(Destination.planSession, arguments: SessionArgs(null)),
        endIcon: SvgPicture.asset(
          'assets/images/ic_dumbbell.svg',
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  onTapLogSession(Session sessionToLog) {
    Navigator.of(context)
        .pushNamed(Destination.logSession, arguments: sessionToLog);
  }

  onTapEditSession(Session sessionToEdit) {
    Navigator.of(context).pushNamed(Destination.planSession,
        arguments: SessionArgs(sessionToEdit));
  }
}
