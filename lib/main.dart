import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/app_router.dart';
import 'package:ppl_course/res/color/colors.dart';

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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColor.dark,
        scaffoldBackgroundColor: AppColor.light
      ),
      onGenerateRoute: _router.onGenerateRoute,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BasicBloc>(create: (context) => BasicBloc()),
          BlocProvider<CyclesBloc>(create: (context) => CyclesBloc())
        ],
        child: const HomePage(title: 'PPL  Course Demo'),
      ),
    );
  }
}
