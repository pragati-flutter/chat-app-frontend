import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class JoinUseCase {
final ChatRepository repository;
JoinUseCase(this.repository);
void call(String username){
  repository.join(username);
}
}