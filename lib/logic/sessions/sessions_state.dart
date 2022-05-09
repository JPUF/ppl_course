part of 'sessions_bloc.dart';

abstract class SessionsState {
  static const initial = 'InitialState';
  static const allSessions = 'AllSessionsState';
  static const lastSessionOfType = 'LastSessionOfTypeState';
  static const stateType = 'stateType';
  static const pendingSessions = 'pendingSessions';
  static const completedSessions = 'completedSessions';

  Map<String, dynamic> toMap();

  String toJson();

  factory SessionsState.fromMap(Map<String, dynamic> map) {
    switch (map[stateType]) {
      case lastSessionOfType:
        final pendingSessionsList = map[pendingSessions] as List;
        final completedSessionsList = map[completedSessions] as List;
        final combinedList = pendingSessionsList + completedSessionsList;
        return LastSessionOfTypeState(Session.fromMap(combinedList.first));
      case allSessions:
        return AllSessionsState(
          pendingSessions: List<Session>.from(map[pendingSessions]?.map((y) {
            Session.fromMap(y);
          })),
          completedSessions:
              List<Session>.from(map[completedSessions]?.map((y) {
            Session.fromMap(y);
          })),
        );
      default:
        return InitialState();
    }
  }

  factory SessionsState.fromJson(String source) =>
      SessionsState.fromMap(json.decode(source));
}

class InitialState implements SessionsState {
  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({
      SessionsState.stateType: SessionsState.initial,
      SessionsState.pendingSessions: null,
      SessionsState.completedSessions: null
    });
    return result;
  }
}

class AllSessionsState implements SessionsState {
  final List<Session> pendingSessions;
  final List<Session> completedSessions;

  AllSessionsState(
      {required this.pendingSessions, required this.completedSessions});

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({
      SessionsState.stateType: SessionsState.allSessions,
      SessionsState.pendingSessions:
          pendingSessions.map((x) => x.toMap()).toList(),
      SessionsState.completedSessions:
          completedSessions.map((x) => x.toMap()).toList()
    });
    return result;
  }
}

class LastSessionOfTypeState implements SessionsState {
  final Session? lastSession;

  LastSessionOfTypeState(this.lastSession);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    final isCompleted = lastSession?.completed ?? false;
    final result = <String, dynamic>{};
    result.addAll({
      SessionsState.stateType: SessionsState.lastSessionOfType,
      SessionsState.pendingSessions: isCompleted ? null : [lastSession],
      SessionsState.completedSessions: isCompleted ? [lastSession] : null
    });
    return result;
  }
}

class SessionToEditState implements SessionsState {
  final Session sessionToEdit;

  SessionToEditState(this.sessionToEdit);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    // Empty implementation as this State needn't persist.
    return {};
  }
}
