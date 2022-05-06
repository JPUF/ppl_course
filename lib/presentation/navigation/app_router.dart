import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/presentation/pages/home/home_page.dart';
import 'package:ppl_course/presentation/pages/log_session/log_session_page.dart';
import 'package:ppl_course/presentation/pages/plan_session/plan_session_page.dart';

import 'destination.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Destination.root:
        return PageTransition(
            child: const HomePage(), type: PageTransitionType.fade);
      case Destination.planSession:
        final Session? session = routeSettings.arguments as Session?;
        return PageTransition(
            child: PlanSessionPage(editSession: session),
            settings: routeSettings,
            type: PageTransitionType.rightToLeftWithFade);
      case Destination.logSession:
        final Session? session = routeSettings.arguments as Session?;
        if (session != null) {
          return PageTransition(
            child: LogSessionPage(session: session),
            settings: routeSettings,
            type: PageTransitionType.rightToLeftWithFade,
          );
        } else {
          return null;
        }

      default:
        return null;
    }
  }
}
