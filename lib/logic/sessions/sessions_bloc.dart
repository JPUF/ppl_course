import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc() : super(SessionsInitial()) {
    on<SessionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

@immutable
abstract class SessionsEvent {}

class FetchSession extends SessionsEvent{
  final SessionArgs sessionArgs;
  FetchSession(this.sessionArgs);
}

@immutable
abstract class SessionsState {}

class SessionsInitial extends SessionsState {}

