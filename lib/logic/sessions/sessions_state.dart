part of 'sessions_bloc.dart';

abstract class SessionsState {
  static const initial = 'InitialState';
  static const allSessions = 'AllSessionsState';
  static const lastSessionOfType = 'LastSessionOfTypeState';
  static const stateType = 'stateType';
  static const sessions = 'sessions';

  Map<String, dynamic> toMap();

  String toJson();

  factory SessionsState.fromMap(Map<String, dynamic> map) {
    switch (map[stateType]) {
      case lastSessionOfType:
        final sessionsList = map[sessions] as List;
        return LastSessionOfTypeState(Session.fromMap(sessionsList.first));
      case allSessions:
        return AllSessionsState(
          List<Session>.from(map[sessions]?.map((y) {
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
      SessionsState.sessions: null
    });
    return result;
  }
}

class AllSessionsState implements SessionsState {
  final List<Session> allSessions;

  AllSessionsState(this.allSessions);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({
      SessionsState.stateType: SessionsState.allSessions,
      SessionsState.sessions: allSessions.map((x) => x.toMap()).toList()
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
    final result = <String, dynamic>{};
    result.addAll({
      SessionsState.stateType: SessionsState.allSessions,
      SessionsState.sessions: [lastSession]
    });
    return result;
  }
}