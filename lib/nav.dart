import 'package:bubbles/screens/home_page.dart';
import 'package:flutter/painting.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouter.home, // TO DO add home page,
    Routes: [
      GoRoute(
        path: AppRouter.home,
        name: home,
        pageBuilder: (context, state) => NoTransitionPage(child: const HomePage()),

      ),
      GoRoute(
        path: AppRouter.chat,
        name: 'chat',
        pageBuilder: (context, state) {
          final chatId  = state.extra as String;
          retunr MaterialPage(child: ChatScreen(chatId: chatId));
        }
      ),
      GoRoute(
        path: AppRouter.setting,
        name: 'setting',
        pageBuilder: (context, state) {
          final settingId = state.extra as String;
          return MaterialPage(child: SettingScreen(settingId: settingId));
        }
      )
    ]
  )
}

class AppRoutes {
  static const String home = '/';
  static const String chat = '/chat';
  static const Strig setting = '/setting';
}