import 'dart:async';
import 'dart:convert';

import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/features/chat/data/model/user_model.dart';
import 'package:chat_app/features/chat/domain/entities/message_entities.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/message_model.dart';

class WebSocketDataSource {
  late WebSocketChannel _channel;
  final _messageController = StreamController<MessageModel>.broadcast();
  final _userController = StreamController<List<UserModel>>.broadcast();

  Stream<MessageModel> get onMessageReceived => _messageController.stream;
  Stream<List<UserModel>> get onUsersReceived => _userController.stream;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(AppConstant.wsUrl));

    _channel.stream.listen(
      (data) {
        _handleMessage(data);
      },
      onError: (error) {
        debugPrint("WebSocket error $error");
      },
      onDone: () {
        debugPrint("WebSocket disconnect");
      },
    );
  }

  void _handleMessage(dynamic data){
    final parsed = jsonDecode(data);
    final type = parsed['type'];

    if(type == 'message'){
      final message = MessageModel.fromJson(parsed);
      _messageController.add(message);

    }
    if(type == 'online_users'){
      final users = (parsed['users'] as List).map((u)=>UserModel.fromUser(u)).toList();
      _userController.add(users);
    }
  }

  void join(String username){
    _channel.sink.add(jsonEncode(
      {'type': 'join',
      'username':username}
    ));
  }



 void sendMessage(String toUserId,String text){
    _channel.sink.add(jsonEncode({
      jsonEncode({
        'type':'message',
        'toUserId': toUserId,
        'text': text
      })
    }));
 }



  // Online users maango
  void getOnlineUsers() {
    _channel.sink.add(jsonEncode({
      'type': 'get_users',
    }));
  }

  // Chat history maango
  void getChatHistory(String withUserId) {
    _channel.sink.add(jsonEncode({
      'type': 'get_history',
      'withUserId': withUserId,
    }));
  }

  // Connection band karo
  void disconnect() {
    _messageController.close();
    _userController.close();
    _channel.sink.close();
  }
}
