import 'package:collection/collection.dart';
import 'package:ppl_course/data/models/session/session.dart';

class SessionRepository {
  List<Session> _sessions = [];

  List<Session> getAllSessions() {
    return _sessions;
  }

  void writeSession(Session session) {
    _sessions.insert(0, session);
  }

  void editSession(Session editedSession) {
    final indexOfOldSession =
        _sessions.indexWhere((s) => s.uuid == editedSession.uuid);
    if (indexOfOldSession >= 0 && indexOfOldSession < _sessions.length) {
      _sessions[indexOfOldSession] = editedSession;
    }
  }

  void deleteSession(Session sessionToDelete) {
    _sessions.removeWhere((s) => s.uuid == sessionToDelete.uuid);
  }

  void setSessions(List<Session> sessions) {
    _sessions = sessions;
  }

  Session? getLastSessionOfType(SessionType type) {
    final Session? lastSessionOfType =
        _sessions.lastWhereOrNull((session) => session.type == type);
    return lastSessionOfType;
  }
}
