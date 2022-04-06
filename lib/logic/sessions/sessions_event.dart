part of 'sessions_bloc.dart';

@immutable
abstract class SessionsEvent {}

class FetchSession extends SessionsEvent{
  final SessionArgs sessionArgs;
  FetchSession(this.sessionArgs);
}
