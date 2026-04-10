import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/app_router.dart';
import '../../domain/entities/user_entites.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final UserEntity user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String myUserID = "0";

  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(GetChatHistoryEvent(widget.user.userId));
  }

  void _sendMessage() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    context.read<ChatBloc>().add(SendMessage(widget.user.userId, text));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.user.userName ?? "Unknown";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(name)),
        body: Column(
          children: [
            Expanded(
              child: BlocListener<ChatBloc, ChatState>(
                listener: (context, state) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    }
                  });
                },
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    final messages = state.messages;
                    // print("message is list ...${messages[1].fromUserId}");

                    if (messages.isEmpty) {
                      return const Center(child: Text("No messages yet"));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];

                        debugPrint(
                          "Message text is given by...${messages[index].text}",
                        );

                        final isMe = msg.fromUserId == state.myUserId;

                        debugPrint(
                          'drom user id ${msg.fromUserId} and to userId ${state.myUserId}',
                        );

                        debugPrint('is me vaue id given by ...$isMe');

                        return _MessageBubble(text: msg.text ?? '', isMe: isMe);
                      },
                    );
                  },
                ),
              ),
            ),

            // INPUT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.deepPurple),
                      onPressed: () {
                        _sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const _MessageBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
