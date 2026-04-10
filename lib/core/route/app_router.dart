import 'package:flutter/material.dart';
import '../../features/chat/domain/entities/user_entites.dart';
import '../../features/chat/presentation/screens/login_screen.dart';
import '../../features/chat/presentation/screens/user_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';

class AppRouter {
  // Route names
  static const String login = '/';
  static const String users = '/users';
  static const String chat = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case users:
        return MaterialPageRoute(
          builder: (_) => const UsersScreen(),
        );

      case chat:
      // UserEntity arguments se lo
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(user: user,),
        );
    // Koi bhi unknown route aaye toh login pe bhejo
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}