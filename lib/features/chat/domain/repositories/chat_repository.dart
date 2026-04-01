import 'dart:async';

import 'package:chat_app/features/chat/domain/entities/user_entites.dart';

import '../entities/message_entities.dart';

abstract class ChatRepository {
  //connect to server
  void connect();
  //send join msg to sever
  void join(String name);

  //send private msg
  void sendMessage(String toUserId, String text);
  //get list of online user
  void getOnlineUser();
  //get old chat history
  void getChatHistory(String withUserId);
  //listen message coming from server - stream
  Stream<MessageEntity> get onMessageReceived;
  //listen online user stream
  Stream<UserEntity> get onlineUserEntity;

  //disconnect
  void disconnect();
}
