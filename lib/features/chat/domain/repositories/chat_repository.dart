import '../entities/message_entities.dart';
import '../entities/user_entites.dart';

abstract class ChatRepository {
  void connect();
  void join(String name);
  void sendMessage(String toUserId, String text,String userId);

  void getOnlineUsers(); 
  void getChatHistory(String withUserId);

  Stream<MessageEntity> get onMessageReceived;
  Stream<List<UserEntity>> get onUserReceived;
  Stream<List<MessageEntity>> get onHistoryReceived;
  Stream<String> get onConnected;

  void disconnect();
}