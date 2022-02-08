import 'package:ppl_course/data/models/basic/todo_model.dart';
import 'package:ppl_course/data/network/api.dart';

class BasicRepository {
  final Api _apiHelper = Api();

  Future<Todo> getTodo() async {
    final response = await _apiHelper.get("/todos/1");
    return Todo.fromJson(response);
  }
}
