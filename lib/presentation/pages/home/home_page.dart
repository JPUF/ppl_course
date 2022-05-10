import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/pages/home/components/session_widget.dart';
import 'package:ppl_course/presentation/pages/log_session/log_session_page.dart';
import 'package:ppl_course/res/string/strings.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.toEditSession,
  }) : super(key: key);

  final ValueSetter<Session> toEditSession;

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
            final pendingSessions = state.pendingSessions;
            final completedSessions = state.completedSessions;
            return Container(
                padding: const EdgeInsets.only(bottom: 64),
                child: Column(
                    children: sessionsOrEmpty(
                            Strings.upcomingSessions, pendingSessions) +
                        [const SizedBox(height: 16)] +
                        sessionsOrEmpty(
                            Strings.completedSessions, completedSessions)));
          } else {
            return const SizedBox(height: 16);
          }
        });
  }

  List<Widget> sessionsOrEmpty(String header, List<Session> sessions) {
    if (sessions.isNotEmpty) {
      return [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(header, style: AppTextStyles.headline4)),
        const SizedBox(height: 8),
        buildSessionColumn(sessions)
      ];
    } else {
      return [];
    }
  }

  Column buildSessionColumn(List<Session> sessions) {
    return Column(
      children: sessions
          .map((session) => GestureDetector(
                onTap: () => onTapLogSession(session),
                child: SessionWidget(
                    session: session,
                    onTappedLog: () => onTapLogSession(session),
                    onTappedEdit: () => onTapEditSession(session)),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.appTitle, style: AppTextStyles.barTitle),
      ),
      body: SafeArea(
        child: buildHomePageContent(),
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

  void toPlanSession() {
    // widget.toBottomNavDestination(BottomNavDestination.plan);
  }

  onTapLogSession(Session sessionToLog) {
    pushNewScreen(context, screen: LogSessionPage(session: sessionToLog));
  }

  onTapEditSession(Session sessionToEdit) {
    widget.toEditSession(sessionToEdit);
  }
}
