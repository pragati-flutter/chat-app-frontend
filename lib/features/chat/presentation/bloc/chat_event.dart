import 'dart:ui';

import 'package:chat_app/features/chat/domain/entities/message_entities.dart';
import 'package:chat_app/features/chat/domain/entities/user_entites.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class ConnectedEvent extends ChatEvent {
  final String userId;

  ConnectedEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class JoinEvent extends ChatEvent {
  final String userName;
  JoinEvent(this.userName);
  @override
  List<Object?> get props => [userName];
}

class SendMessage extends ChatEvent {
  final String toUserId;
  final String text;
  SendMessage(this.toUserId, this.text);
  @override
  List<Object?> get props => [toUserId, text];
}

class GetUserEvent extends ChatEvent {}

class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;
  MessageReceivedEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class UserReceivedEvent extends ChatEvent {
  final List<UserEntity> users;
  UserReceivedEvent(this.users);
  @override
  List<Object?> get props => [users];
}

class GetChatHistoryEvent extends ChatEvent {
  final String withUserId;

  GetChatHistoryEvent(this.withUserId);

  @override
  List<Object?> get props => [withUserId];
}

class ChatHistoryReceivedEvent extends ChatEvent {
  final List<MessageEntity> messages;

  ChatHistoryReceivedEvent(this.messages);

  @override
  List<Object?> get props => [messages];
}
