import 'package:chat_app/features/chat/domain/usecases/get_message_history_usecase.dart';
import 'package:get_it/get_it.dart';
import '../data/datasource/web_socket_datasource.dart';
import '../data/repositories/chat_repository_implementation.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/usecases/connect_user_usecase.dart';
import '../domain/usecases/join_usecase.dart';
import '../domain/usecases/send_message_usecase.dart';
import '../domain/usecases/get_users_usecase.dart';
import '../presentation/bloc/chat_bloc.dart';

final sl = GetIt.instance;

void setupChatDependencies() {
  // Datasource
  sl.registerLazySingleton<WebSocketDataSource>(() => WebSocketDataSource());

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(datasource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => ConnectUseCase(sl()));
  sl.registerLazySingleton(() => JoinUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => GetMessageHistoryUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => ChatBloc(
      connectUseCase: sl() ,
      joinUseCase: sl(),
      sendMessageUseCase: sl(),
      getUserUseCase: sl(),
      getMessageHistoryUseCase: sl(),

      chatRepository: sl(),
    ),
  );
}
