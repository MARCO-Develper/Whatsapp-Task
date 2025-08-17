import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_event.dart';
import 'package:whatsapp_task/feature/presentation/widget/animated_message_bubble.dart';
import '../../domain/entities/chat.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _sendAnimationController;
  late AnimationController _appBarAnimationController;

  @override
  void initState() {
    super.initState();
    _sendAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Start app bar animation
    Future.delayed(const Duration(milliseconds: 100), () {
      _appBarAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _appBarAnimationController,
            curve: Curves.easeOutBack,
          )),
          child: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                Hero(
                  tag: 'avatar_${widget.chat.id}',
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: _getAvatarColor(widget.chat.name),
                    child: Text(
                      widget.chat.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.chat.isOnline ? 'online' : 'last seen recently',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: const Icon(Icons.call), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0B141A) : const Color(0xFFE5DDD5),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: widget.chat.messages.length,
                itemBuilder: (context, index) {
                  final message = widget
                      .chat.messages[widget.chat.messages.length - 1 - index];
                  return AnimatedMessageBubble(
                    message: message,
                    index: index,
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: isDark ? const Color(0xFF1F2C33) : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A3942) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isDark ? Colors.transparent : Colors.grey[300]!,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      maxLines: 5,
                      minLines: 1,
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  if (_messageController.text.isEmpty)
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {},
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.8).animate(
              CurvedAnimation(
                parent: _sendAnimationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: const Color(0xFF25D366),
              onPressed: _sendMessage,
              child: Icon(
                _messageController.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _sendAnimationController.forward().then((_) {
        _sendAnimationController.reverse();
      });

      context.read<ChatBloc>().add(
            SendMessageEvent(
              chatId: widget.chat.id,
              messageText: _messageController.text.trim(),
            ),
          );

      _messageController.clear();

      // Auto scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.red[400]!,
      Colors.pink[400]!,
      Colors.purple[400]!,
      Colors.deepPurple[400]!,
      Colors.indigo[400]!,
      Colors.blue[400]!,
      Colors.lightBlue[400]!,
      Colors.cyan[400]!,
      Colors.teal[400]!,
      Colors.green[400]!,
      Colors.lightGreen[400]!,
      Colors.lime[400]!,
      Colors.yellow[400]!,
      Colors.amber[400]!,
      Colors.orange[400]!,
      Colors.deepOrange[400]!,
    ];

    return colors[name.hashCode % colors.length];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _sendAnimationController.dispose();
    _appBarAnimationController.dispose();
    super.dispose();
  }
}
