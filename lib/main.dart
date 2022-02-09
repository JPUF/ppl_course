import 'package:ppl_course/data/models/exercise/sets_reps.dart';
import 'package:ppl_course/logic/cycles/cycles_bloc.dart';
import 'package:ppl_course/presentation/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/cycle/session.dart';
import 'data/models/exercise/exercise.dart';
import 'logic/basic/basic_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPL Course Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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
