import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ppl_course/data/models/exercise/exercise_names.dart';
import 'package:ppl_course/data/repositories/exercise_repository.dart';
import 'package:ppl_course/logic/exercises/exercises_bloc.dart';
import 'package:ppl_course/logic/sessions/sessions_bloc.dart';
import 'package:ppl_course/presentation/navigation/app_router.dart';
import 'package:ppl_course/presentation/pages/menu/bottom_nav_screen.dart';
import 'package:ppl_course/res/color/colors.dart';

import 'logic/basic/basic_bloc.dart';
import 'presentation/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseNamesAdapter());
  await Hive.openBox(ExerciseRepository.exerciseBox);

  HydratedBlocOverrides.runZoned(() => runApp(MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BasicBloc>(create: (context) => BasicBloc()),
        BlocProvider<SessionsBloc>(create: (context) => SessionsBloc()),
        BlocProvider<ExercisesBloc>(create: (context) => ExercisesBloc())
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
          home: const BottomNavScreen()),
    );
  }
}
