import 'package:equatable/equatable.dart';
import 'package:whatsapp_task/feature/domain/entities/call.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class CallInitial extends CallState {}

class CallLoading extends CallState {}

class CallLoaded extends CallState {
  final List<Call> calls;

  const CallLoaded({required this.calls});

  @override
  List<Object> get props => [calls];
}

class CallError extends CallState {
  final String message;

  const CallError({required this.message});

  @override
  List<Object> get props => [message];
}
