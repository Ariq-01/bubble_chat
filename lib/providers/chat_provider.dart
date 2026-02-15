import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading_provider.dart';
import '../widgets/loading_indicator.dart';

class ChatProvider extends StatelessWidget {
  const ChatProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<LoadingProvider>(
            builder: (context, loadingProvider, child) {
              if (loadingProvider.isloading) {
                return const LoadingIndicator();
              } else {
                return const Text("chat content goes on here");
              }
            },
          ),
        ],
      ),
    );
  }
}
