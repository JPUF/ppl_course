import 'package:hive/hive.dart';

part 'exercise_names.g.dart';

@HiveType(typeId: 0)
class ExerciseNames extends HiveObject {
  @HiveField(0)
  List<String> names;

  ExerciseNames(this.names);
}