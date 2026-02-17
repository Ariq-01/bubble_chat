import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bubbles/screens/home_page.dart';
import 'package:bubbles/screens/chat_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => NoTransitionPage(child: const HomePage()),
      ),
      GoRoute(
        path: AppRoutes.chat,
        name: 'chat',
        pageBuilder: (context, state) {
          final chatId = state.extra as String;
          return MaterialPage(child: ChatScreen(chatId: chatId));
        },
      ),
    ],
  );
}

class AppRoutes {
  static const String home = '/';
  static const String chat = '/chat';
}
