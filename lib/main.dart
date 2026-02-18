//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubbles/screens/chat_screen.dart';
// import 'firebase_options.dart';
import 'providers/chat_provider.dart';
import 'package:bubbles/nav.dart';
import 'package:go_router/go_router.dart';

import 'theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'by arcdev',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,// to do add theme later,
      //darkTheme: darkTheme,// add later ,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router /// add this later,
      );
  }
}
