import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String fromUserName;
  final String fromUserId;
  final String toUserId;
  final String time;
  final String text;

  const MessageEntity({
    required this.fromUserName,
    required this.fromUserId,
    required this.toUserId,
    required this.time,
    required this.text,
  });

  @override
  List<Object?> get props => [fromUserName, fromUserId, toUserId, time, text];

  MessageEntity toEntity() {
    return MessageEntity(
      fromUserName: fromUserName,
      fromUserId: fromUserId,
      toUserId: toUserId,
      time: time,
      text: text,
    );
  }
}
