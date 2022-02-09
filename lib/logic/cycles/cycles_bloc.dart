import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppl_course/data/models/cycle/cycle.dart';
import 'package:ppl_course/data/network/response.dart';
import 'package:ppl_course/data/repositories/cycle_repository.dart';

part 'cycles_state.dart';

abstract class CyclesEvent {}

class FetchCycles implements CyclesEvent {}

class CyclesBloc extends Bloc<CyclesEvent, Response<CyclesState>> {
  final CycleRepository _cycleRepository = CycleRepository();

  CyclesBloc() : super(Response.loading("Loading Cycles")) {
    on<FetchCycles>(_onFetch);
  }

  void _onFetch(FetchCycles event, Emitter<Response<CyclesState>> emit) async {
    emit(Response.loading("Loading Cycles"));
    var state = CyclesState();
    state.cycles = _cycleRepository.getCycles();
    emit(Response.completed(state));
  }
}
