import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_state.dart';
import 'package:whatsapp_task/feature/presentation/widget/animated_chat_tile.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text("Error loading chats"),
                ElevatedButton(
                  onPressed: () => context.read<ChatBloc>().add(GetChatsEvent()),
                  child: const Text("Retry"),
                )
              ],
            ),
          );
        } else if (state is ChatLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ChatBloc>().add(GetChatsEvent());
            },
            child: ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return AnimatedChatTile(
                  chat: chat,
                  index: index,
                  onTap: () {
                    // TODO: open chat screen
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
