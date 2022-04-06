import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ppl_course/presentation/pages/exercise/exercise_page.dart';
import 'package:ppl_course/presentation/pages/home/home_page.dart';

import 'destination.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Destination.root:
        return PageTransition(
            child: const HomePage(title: "Home"),
            type: PageTransitionType.fade);
      case Destination.exercise:
        return PageTransition(
            child: const ExercisePage(title: "Exercise"),
            settings: routeSettings,
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return null;
    }
  }
}
