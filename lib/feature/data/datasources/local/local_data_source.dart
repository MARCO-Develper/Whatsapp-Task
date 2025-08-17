import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/feature/data/models/call_model.dart';
import 'package:whatsapp_task/feature/data/models/chat_model.dart';
import 'package:whatsapp_task/feature/data/models/message_model.dart';
import 'package:whatsapp_task/feature/data/models/story_model.dart';
import 'package:whatsapp_task/feature/domain/entities/message.dart';

abstract class LocalDataSource {
  Future<List<ChatModel>> getAllChats();
  Future<List<StoryModel>> getAllStories();
  Future<List<CallModel>> getAllCalls();
  Future<MessageModel> sendMessage(String chatId, String messageText);
}

class LocalDataSourceImpl implements LocalDataSource {
  List<ChatModel> _cachedChats = [];

  @override
  Future<List<ChatModel>> getAllChats() async {
    try {
      if (_cachedChats.isEmpty) {
        final jsonString =
            await rootBundle.loadString('assets/data/chats.json');
        final jsonData = json.decode(jsonString);
        _cachedChats = (jsonData['chats'] as List)
            .map((chat) => ChatModel.fromJson(chat))
            .toList();
      }
      return _cachedChats;
    } catch (e) {
      throw DataParsingFailure('Failed to load chats: $e');
    }
  }

  @override
  Future<List<StoryModel>> getAllStories() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/stories.json');
      final jsonData = json.decode(jsonString);
      return (jsonData['stories'] as List)
          .map((story) => StoryModel.fromJson(story))
          .toList();
    } catch (e) {
      throw DataParsingFailure('Failed to load stories: $e');
    }
  }

  @override
  Future<List<CallModel>> getAllCalls() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/calls.json');
      final jsonData = json.decode(jsonString);
      return (jsonData['calls'] as List)
          .map((call) => CallModel.fromJson(call))
          .toList();
    } catch (e) {
      throw DataParsingFailure('Failed to load calls: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage(String chatId, String messageText) async {
    final now = DateTime.now();
    final message = MessageModel(
      id: Random().nextInt(10000).toString(),
      text: messageText,
      isMe: true,
      time:
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      type: MessageType.text,
      status: MessageStatus.sent,
    );

    // Update cached chat
    final chatIndex = _cachedChats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      final chat = _cachedChats[chatIndex];
      final updatedMessages = List<Message>.from(chat.messages)..add(message);

      _cachedChats[chatIndex] = ChatModel(
        id: chat.id,
        name: chat.name,
        lastMessage: messageText,
        time: message.time,
        isOnline: chat.isOnline,
        unreadCount: 0,
        avatarUrl: chat.avatarUrl,
        messages: updatedMessages,
      );
    }

    return message;
  }
}
