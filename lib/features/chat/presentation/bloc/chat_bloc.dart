import 'package:chat_app/features/chat/domain/entities/message_entities.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_user_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_message_history_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_users_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/join_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:bloc/bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final JoinUseCase joinUseCase;
  final GetUserUseCase getUserUseCase;
  final GetMessageHistoryUseCase getMessageHistoryUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ChatRepository chatRepository;
  final ConnectUseCase connectUseCase;

  ChatBloc({
    required this.joinUseCase,
    required this.getUserUseCase,
    required this.getMessageHistoryUseCase,
    required this.sendMessageUseCase,
    required this.chatRepository,
    required this.connectUseCase,
  }) : super(ChatState()) {
    chatRepository.onMessageReceived.listen((message) {
      add(MessageReceivedEvent(message));
    });

    chatRepository.onUserReceived.listen((user) {
      add(UserReceivedEvent(user));
    });

    chatRepository.onConnected.listen((userId) {
      add(ConnectedEvent(userId));
    });

    on<ConnectedEvent>((event, emit) {
      print("connect bloc is called");
      emit(state.copyWith(myUserId: event.userId));
    });


    on<ConnectEvent>((event, emit) {
      print("connect bloc is called");
      connectUseCase();
    });

    on<JoinEvent>((event, emit) {
      joinUseCase(event.userName);
      emit(state.copyWith(myUsername: event.userName, isConnected: true));
    });

    on<SendMessage>((event, emit) async {
      final myId = state.myUserId;

      if (myId == null) {
        print("❌ myUserId is null — CONNECT FIRST");
        return;
      }

      // 👉 LOCAL MESSAGE CREATE (UI ke liye)
      final newMessage = MessageEntity(
        text: event.text,
        fromUserId: myId,
        toUserId: event.toUserId, fromUserName: '', time: '',
      );

      // 👉 UI instantly update
      final updatedMessages = List<MessageEntity>.from(state.messages)
        ..add(newMessage);

      emit(state.copyWith(messages: updatedMessages));

      // 👉 Backend call
       sendMessageUseCase(event.toUserId, event.text, myId);
    });

    on<GetUserEvent>((event, emit) {
      getUserUseCase();
    });

    on<MessageReceivedEvent>((event, emit) {
      final updateMessages = List<MessageEntity>.from(state.messages)
        ..add(event.message);
      emit(state.copyWith(messages: updateMessages));
    });

    on<UserReceivedEvent>((event, emit) {
      emit(state.copyWith(onlineUsers: event.users));
    });

    on<GetChatHistoryEvent>((event, emit) {
      getMessageHistoryUseCase(event.withUserId);
    });
  }
}
