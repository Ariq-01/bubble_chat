import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
              Container(padding: const EdgeInsets.all(16),
              child: Image.asset(
              'assets/logo.png', height: 50,
            cacheHeight: 100,
            cacheWidth: 100,),
            //const SizedBox(height: 20,),
              ),

              const SizedBox(height: 20,),
          ],
        ),
      )),
    );
  }
}