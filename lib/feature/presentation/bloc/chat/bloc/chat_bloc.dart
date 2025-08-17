import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_chats.dart';
import 'package:whatsapp_task/feature/domain/usecases/send_message.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetAllChats getAllChats;
  final SendMessage sendMessage;

  ChatBloc({
    required this.getAllChats,
    required this.sendMessage,
  }) : super(ChatInitial()) {
    on<GetChatsEvent>(_onGetChats);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onGetChats(GetChatsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    final failureOrChats = await getAllChats(NoParams());

    failureOrChats.fold(
      (failure) => emit(ChatError(message: failure.message)),
      (chats) => emit(ChatLoaded(chats: chats)),
    );
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final failureOrMessage = await sendMessage(
      SendMessageParams(chatId: event.chatId, messageText: event.messageText),
    );

    failureOrMessage.fold(
      (failure) => emit(ChatError(message: failure.message)),
      (message) => emit(MessageSent(message: message)),
    );
  }
}
