import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/cycle/cycle.dart';
import 'package:ppl_course/data/models/cycle/session.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/data/repositories/cycle_repository.dart';
import 'package:ppl_course/presentation/navigation/args/session_args.dart';

part 'cycles_state.dart';

abstract class CyclesEvent {}

class FetchCycles implements CyclesEvent {}

class FetchSession implements CyclesEvent {
  final SessionArgs sessionArgs;

  FetchSession(this.sessionArgs);
}

class CyclesBloc extends Bloc<CyclesEvent, Response<CyclesState>> {
  final CycleRepository _cycleRepository = CycleRepository();

  CyclesBloc() : super(Response.loading(null)) {
    on<FetchCycles>(_fetchAllCycles);
    on<FetchSession>(_fetchSession);
  }

  void _fetchAllCycles(
      FetchCycles event, Emitter<Response<CyclesState>> emit) async {
    emit(Response.loading("Loading Cycles"));
    var state = AllCyclesState();
    state.cycles = _cycleRepository.getCycles();
    emit(Response.completed(state));
  }

  void _fetchSession(
      FetchSession event, Emitter<Response<CyclesState>> emit) async {
    emit(Response.loading("Loading Cycles"));
    var state = SessionState();
    final session = _cycleRepository.getSession(event.sessionArgs);
    if (session != null) {
      state.session = session;
      emit(Response.completed(state));
    } else {
      emit(Response.error("Error fetching session ${event.sessionArgs}"));
    }
  }
}
