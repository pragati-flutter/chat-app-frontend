import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(ConnectEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onJoinPressed() {
    final username = _usernameController.text.trim();

    // Agar naam khali hai toh kuch mat karo
    if (username.isEmpty) return;

    // JOIN event bhejo Bloc ko
    context.read<ChatBloc>().add(JoinEvent(username));

    // Users Screen pe jao
    Navigator.pushReplacementNamed(context, '/users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'Chat App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 48),

            // Username field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Apna naam likho',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Join button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onJoinPressed,
                child: const Text('Join Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
