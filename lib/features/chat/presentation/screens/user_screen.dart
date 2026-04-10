import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/app_router.dart';
import '../../domain/entities/user_entites.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Online Users',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          debugPrint("state is given by...${state.myUserId}");

          // 🔄 Loading state
          if (state.onlineUsers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Remove current user from list
          final users = state.onlineUsers.where((u) {
            debugPrint('my user id is given by ...${state.myUserId}');
            return u.userId != state.myUserId;
          }).toList();

          // 📴 No other users
          if (users.isEmpty) {
            return const Center(child: Text("No other users online"));
          }

          // ✅ Show users
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _UserTile(user: users[index]);
            },
          );
        },
      ),
    );
  }
}

// ── USER TILE ──
class _UserTile extends StatelessWidget {
  final UserEntity user;

  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user.userName;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Text(
          name!.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),

      trailing: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),

      onTap: () {
        Navigator.pushNamed(context, AppRouter.chat, arguments: user);
      },
    );
  }
}
