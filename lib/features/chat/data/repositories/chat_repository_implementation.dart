import 'package:flutter/cupertino.dart';

import '../../domain/entities/message_entities.dart';
import '../../domain/entities/user_entites.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasource/web_socket_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final WebSocketDataSource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  void connect() {
    debugPrint("data layer repository is called ");
    datasource.connect();
  }

  @override
  void join(String name) => datasource.join(name);

  @override
  void sendMessage(String toUserId, String text,String userId) =>
      datasource.sendMessage(toUserId, text,userId);

  @override
  void getOnlineUsers() => datasource.getOnlineUsers();

  @override
  void getChatHistory(String withUserId) =>
      datasource.getChatHistory(withUserId);

  @override
  Stream<MessageEntity> get onMessageReceived =>
      datasource.onMessageReceived.map((model) => model.toEntity());

  @override
  Stream<List<UserEntity>> get onUserReceived =>
      datasource.onUsersReceived.map(
            (list) => list.map((e) => e.toEntity()).toList(),
      );
  @override
  Stream<List<MessageEntity>> get onHistoryReceived =>
      datasource.onHistoryReceived.map(
            (list) => list.map((e) => e.toEntity()).toList(),
      );
  @override
  void disconnect() => datasource.disconnect();

  @override
  // TODO: implement onConnected
  @override
  Stream<String> get onConnected => datasource.onConnected;

}