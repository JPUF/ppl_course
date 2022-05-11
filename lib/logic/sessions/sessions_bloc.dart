import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ppl_course/data/models/session/session.dart';
import 'package:ppl_course/data/repositories/session_repository.dart';

part 'sessions_state.dart';

abstract class SessionsEvent {}

class FetchLastSessionOfType implements SessionsEvent {
  final SessionType type;

  FetchLastSessionOfType(this.type);
}

class WriteSession implements SessionsEvent {
  final Session session;

  WriteSession(this.session);
}

class EditSession implements SessionsEvent {
  final Session editedSession;

  EditSession(this.editedSession);
}

class DeleteSession implements SessionsEvent {
  final Session sessionToDelete;

  DeleteSession(this.sessionToDelete);
}

class SessionsBloc extends Bloc<SessionsEvent, SessionsState>
    with HydratedMixin {
  final SessionRepository _sessionRepository;

  SessionsBloc(this._sessionRepository) : super(InitialState()) {
    on<FetchLastSessionOfType>(_fetchLastSessionOfType);
    on<WriteSession>(_writeSession);
    on<EditSession>(_editSession);
    on<DeleteSession>(_deleteSession);
  }

  void _fetchLastSessionOfType(
      FetchLastSessionOfType event, Emitter<SessionsState> emit) async {
    final lastSession = _sessionRepository.getLastSessionOfType(event.type);
    emit(LastSessionOfTypeState(lastSession));
  }

  void _writeSession(WriteSession event, Emitter<SessionsState> emit) async {
    _sessionRepository.writeSession(event.session);
    emit(AllSessionsState(
        pendingSessions: _sessionRepository.getAllPendingSessions(),
        completedSessions: _sessionRepository.getAllCompletedSessions()));
  }

  void _editSession(EditSession event, Emitter<SessionsState> emit) async {
    _sessionRepository.editSession(event.editedSession);
    emit(AllSessionsState(
        pendingSessions: _sessionRepository.getAllPendingSessions(),
        completedSessions: _sessionRepository.getAllCompletedSessions()));
  }

  void _deleteSession(DeleteSession event, Emitter<SessionsState> emit) async {
    _sessionRepository.deleteSession(event.sessionToDelete);
    emit(AllSessionsState(
        pendingSessions: _sessionRepository.getAllPendingSessions(),
        completedSessions: _sessionRepository.getAllCompletedSessions()));
  }

  @override
  SessionsState? fromJson(Map<String, dynamic> json) {
    final stateType = json[SessionsState.stateType];
    switch (stateType) {
      case SessionsState.allSessions:
        final pendingSessions = (json[SessionsState.pendingSessions] as List)
            .map((a) => Session.fromMap(a))
            .toList();
        final completedSessions =
            (json[SessionsState.completedSessions] as List)
                .map((a) => Session.fromMap(a))
                .toList();

        _sessionRepository.setSessions(pendingSessions + completedSessions);
        return AllSessionsState(
          pendingSessions: pendingSessions,
          completedSessions: completedSessions,
        );
      case SessionsState.lastSessionOfType:
        final pendingSessions = json[SessionsState.pendingSessions] as List;
        final completedSessions = json[SessionsState.completedSessions] as List;
        final combined = pendingSessions + completedSessions;
        return LastSessionOfTypeState(combined.first);
      default:
        return InitialState();
    }
  }

  @override
  Map<String, dynamic>? toJson(SessionsState state) {
    if (state is AllSessionsState) {
      return AllSessionsState(
        pendingSessions: state.pendingSessions,
        completedSessions: state.completedSessions,
      ).toMap();
    } else if (state is LastSessionOfTypeState) {
      return LastSessionOfTypeState(state.lastSession).toMap();
    } else {
      return InitialState().toMap();
    }
  }
}
