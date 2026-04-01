import 'package:chat_app/features/chat/domain/entities/message_entities.dart';

class MessageModel extends MessageEntity{
  const MessageModel({required super.fromUserName, required super.fromUserId, required super.toUserId, required super.time, required super.text});

  factory MessageModel.fromJson(Map<String,dynamic>json){
    return MessageModel(
      fromUserId: json['from_user_id'] ?? '',
      fromUserName: json['to_Username'] ?? '',
      toUserId: json['to_user_id'] ?? '',
      text: json['text'] ?? '',
      time: json['createdAt'] ?? '',

   );
  }

  Map<String,dynamic>toJson(){
    return {
      'from_user_id': fromUserId,
      'fromUsername': fromUserName,
      'to_user_id': toUserId,
      'text': text,
      'created_at': time,
    };
  }
}