import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/data/repositories/session_repository.dart';

abstract class SessionsEvent {}

abstract class SessionsState {}

class FetchAllSessions implements SessionsEvent {}

class WriteSession implements SessionsEvent {
  final Session session;

  WriteSession(this.session);
}

class AllSessions extends SessionsState {
  final List<Session> sessions;

  AllSessions(this.sessions);
}

class WriteSessionSuccess extends SessionsState {}

class SessionsBloc extends Bloc<SessionsEvent, Response<SessionsState>> {
  final SessionRepository _sessionRepository = SessionRepository();

  SessionsBloc() : super(Response.loading(null)) {
    on<FetchAllSessions>(_fetchAllSessions);
    on<WriteSession>(_writeSession);
  }

  void _fetchAllSessions(
      FetchAllSessions event, Emitter<Response<SessionsState>> emit) async {
    emit(Response.loading("Loading Sessions"));
    var state = AllSessions(_sessionRepository.getAllSessions());
    emit(Response.completed(state));
  }

  void _writeSession(
      WriteSession event, Emitter<Response<SessionsState>> emit) async {
    emit(Response.loading("Writing Session"));
    final success = _sessionRepository.writeSession(event.session);
    if (success) {
      emit(Response.completed(WriteSessionSuccess()));
      emit(Response.completed(AllSessions(_sessionRepository.getAllSessions())));
    } else {
      emit(Response.error("Error writing session"));
    }
  }
}
