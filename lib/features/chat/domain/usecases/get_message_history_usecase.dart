import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessageHistoryUseCase{
  final ChatRepository chatRepository;

  const GetMessageHistoryUseCase(this.chatRepository);

  void call(String withUserId ){
    chatRepository.getChatHistory(withUserId);
  }

}
