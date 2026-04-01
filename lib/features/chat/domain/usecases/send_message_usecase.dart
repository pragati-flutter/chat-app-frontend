import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase{
  final ChatRepository chatRepository;
  const SendMessageUseCase(this.chatRepository);
  void call(String toUserId,String text){
    chatRepository.sendMessage(toUserId, text);
  }

}