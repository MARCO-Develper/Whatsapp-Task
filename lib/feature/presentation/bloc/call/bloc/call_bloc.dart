import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_calls.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final GetAllCalls getAllCalls;

  CallBloc({required this.getAllCalls}) : super(CallInitial()) {
    on<GetCallsEvent>(_onGetCalls);
  }

  Future<void> _onGetCalls(GetCallsEvent event, Emitter<CallState> emit) async {
    emit(CallLoading());

    final failureOrCalls = await getAllCalls(NoParams());

    failureOrCalls.fold(
      (failure) => emit(CallError(message: failure.message)),
      (calls) => emit(CallLoaded(calls: calls)),
    );
  }
}
