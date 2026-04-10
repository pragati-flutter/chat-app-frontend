import 'package:get_it/get_it.dart';
import '../../features/chat/di/chat_injection.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {

  setupChatDependencies();
}