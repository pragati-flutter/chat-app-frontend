import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetUserUseCase{
  final ChatRepository chatRepository;
  const GetUserUseCase(this.chatRepository);

  void call(){
    chatRepository.getOnlineUser();
  }
}