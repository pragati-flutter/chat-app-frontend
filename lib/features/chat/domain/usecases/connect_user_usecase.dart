import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ConnectUseCase{
  ChatRepository chatRepository;
   ConnectUseCase(this.chatRepository);

   void call(){
     print("usecase called");
     chatRepository.connect();
   }

}


