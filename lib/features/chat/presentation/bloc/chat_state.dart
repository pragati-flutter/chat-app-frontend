import 'package:chat_app/features/chat/domain/entities/message_entities.dart';
import 'package:chat_app/features/chat/domain/entities/user_entites.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable{
  final List<MessageEntity>messages;
  final List<UserEntity>onlineUsers;
  final String myUserId;
  final String myUserName;
  final bool isConnected;

  const ChatState({this.messages = const[], this.onlineUsers=const[], this.myUserId = '', this.myUserName = '', this.isConnected = false});

  ChatState copyWith({
    List<MessageEntity>? messages,
    List<UserEntity>? onlineUsers,
    String? myUserId,
    String? myUsername,
    bool? isConnected,

}){
    return ChatState(
      messages: messages ?? this.messages,
      myUserName: myUserName,
      myUserId: myUserId ?? this.myUserId,
      onlineUsers: onlineUsers ?? this.onlineUsers,

      isConnected: isConnected ?? this.isConnected,

    );
  }
  @override
  List<Object?> get props => [messages,onlineUsers,myUserId,myUserName,isConnected];

}