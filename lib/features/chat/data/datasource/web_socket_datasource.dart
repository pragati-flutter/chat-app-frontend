import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/constants/app_constants.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class WebSocketDataSource {
  late WebSocketChannel _channel;

  final _messageController = StreamController<MessageModel>.broadcast();
  final _userController = StreamController<List<UserModel>>.broadcast();

  Stream<MessageModel> get onMessageReceived => _messageController.stream;
  Stream<List<UserModel>> get onUsersReceived => _userController.stream;

  final _historyController = StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get onHistoryReceived => _historyController.stream;

  // ✅ ADD THIS
  final _connectionController = StreamController<String>.broadcast();
  Stream<String> get onConnected => _connectionController.stream;

  // ✅ CONNECT
  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(AppConstants.wsUrl),
    );

    _channel.stream.listen(
      _handleMessage,
      onError: (error) => debugPrint("WebSocket error: $error"),
      onDone: () => debugPrint("WebSocket disconnected"),
    );
  }

  // ✅ HANDLE INCOMING DATA
  void _handleMessage(dynamic data) {
    final parsed = jsonDecode(data);
    final type = parsed['type'];

    switch (type) {

      case 'connected': // ✅ NEW
        final userId = parsed['userId'];
        debugPrint("🔥 CONNECTED USER ID: $userId");
        _connectionController.add(userId);
        break;

      case 'message':
        _messageController.add(MessageModel.fromJson(parsed));
        break;

      case 'online_users':
        final users = (parsed['users'] as List)
            .map((u) => UserModel.fromUser(u))
            .toList();

        _userController.add(users);
        break;

      case 'chat_history': // ✅ ADD THIS
        final messages = (parsed['messages'] as List)
            .map((e) => MessageModel.fromJson(e))
            .toList();

        _historyController.add(messages);
        break;
    }
  }
  // ✅ JOIN USER
  void join(String username) {
    debugPrint("Joining with username: $username");

    _channel.sink.add(jsonEncode({
      'type': 'join',
      'username': username,
    }));
  }

  // ✅ GET ONLINE USERS
  void getOnlineUsers() {
    _channel.sink.add(jsonEncode({
      'type': 'get_users',
    }));
  }

  // ✅ SEND MESSAGE
  void sendMessage(String toUserId, String text,String userId) {
    _channel.sink.add(jsonEncode({
      'type': 'message',
      'toUserId': toUserId,
      'text': text,
      'fromUserId':userId
    }));
  }

  // ✅ GET CHAT HISTORY
  void getChatHistory(String withUserId) {
    _channel.sink.add(jsonEncode({
      'type': 'get_history',
      'withUserId': withUserId,
    }));
  }

  // ✅ DISCONNECT
  void disconnect() {
    _connectionController.close();
    _messageController.close();
    _userController.close();
    _channel.sink.close();
  }
}