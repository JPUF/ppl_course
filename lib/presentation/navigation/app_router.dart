import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppl_course/presentation/pages/home/home_page.dart';
import 'package:ppl_course/presentation/pages/session/session_page.dart';

import 'destination.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Destination.root:
        return PageTransition(
            child: const HomePage(),
            type: PageTransitionType.fade);
      case Destination.session:
        return PageTransition(
            child: const SessionPage(),
            settings: routeSettings,
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return null;
    }
  }
}
