import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/basic/todo_model.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/data/repositories/basic/basic_repository.dart';

part 'basic_state.dart';

abstract class BasicEvent {}

class FetchBasic implements BasicEvent {}

class BasicBloc extends Bloc<BasicEvent, Response<BasicState>> {
  final BasicRepository _basicRepository = BasicRepository();

  BasicBloc() : super(Response.completed(BasicState(basicText: ''))) {
    on<FetchBasic>(_onFetch);
  }

  void _onFetch(FetchBasic event, Emitter<Response<BasicState>> emit) async {
    emit(Response.loading("Loading TODO"));
    try {
      Todo todo = await _basicRepository.getTodo();
      emit(Response.completed(BasicState(basicText: todo.title)));
    } catch (e) {
      emit(Response.error("Error fetching TODO"));
    }
  }
}
