import 'package:ppl_course/presentation/pages/home/home_page.dart';
import 'package:ppl_course/presentation/pages/second/second_page.dart';
import 'package:flutter/material.dart';

import 'destination.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Destination.root:
        return MaterialPageRoute(builder: (_) => const HomePage(title: "Home"));
      case Destination.second:
        return MaterialPageRoute(builder: (_) => const SecondPage(title: "Second"));
      default:
        return null;
    }
  }
}