import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/data/repositories/session_repository.dart';

part 'sessions_state.dart';

abstract class SessionsEvent {}

class FetchAllSessions implements SessionsEvent {}

class WriteSession implements SessionsEvent {
  final Session session;

  WriteSession(this.session);
}

class SessionsBloc extends Bloc<SessionsEvent, SessionsState>
    with HydratedMixin {
  final SessionRepository _sessionRepository = SessionRepository();

  SessionsBloc() : super(SessionsState(null)) {
    on<FetchAllSessions>(_fetchAllSessions);
    on<WriteSession>(_writeSession);
  }

  void _fetchAllSessions(
      FetchAllSessions event, Emitter<SessionsState> emit) async {
    var state = SessionsState(_sessionRepository.getAllSessions());
    emit(state);
  }

  void _writeSession(WriteSession event, Emitter<SessionsState> emit) async {
    final success = _sessionRepository.writeSession(event.session);
    if (success) {
      emit(SessionsState(_sessionRepository.getAllSessions()));
    }
  }

  @override
  SessionsState? fromJson(Map<String, dynamic> json) {
    final sessions = (json['sessions'] as List).map((a) => Session.fromMap(a)).toList();
    _sessionRepository.setSessions(sessions);
    return SessionsState(sessions);
  }

  @override
  Map<String, dynamic>? toJson(SessionsState state) {
    return SessionsState(_sessionRepository.getAllSessions()).toMap();
  }
}
