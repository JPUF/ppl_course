import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/navigation/app_router.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/string/strings.dart';

import 'logic/basic/basic_bloc.dart';
import 'presentation/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BasicBloc>(create: (context) => BasicBloc()),
        BlocProvider<SessionsBloc>(create: (context) => SessionsBloc())
      ],
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: AppColor.dark,
              appBarTheme: AppBarTheme(
                  backgroundColor: AppColor.white,
                  foregroundColor: AppColor.dark,
                  elevation: 2),
              scaffoldBackgroundColor: AppColor.white),
          onGenerateRoute: _router.onGenerateRoute,
          home: const HomePage(title: Strings.appTitle)),
    );
  }
}
