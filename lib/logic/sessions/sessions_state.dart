part of 'sessions_bloc.dart';

class SessionsState {
  final List<Session>? sessions;

  SessionsState(this.sessions);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sessions': sessions?.map((x) => x.toMap()).toList()});

    return result;
  }

  factory SessionsState.fromMap(Map<String, dynamic> map) {
    final state = SessionsState(
      List<Session>.from(map['sessions']?.map((y) {
            Session.fromMap(y);
      })),
    );
    return state;
  }

  String toJson() => json.encode(toMap());

  factory SessionsState.fromJson(String source) =>
      SessionsState.fromMap(json.decode(source));
}
