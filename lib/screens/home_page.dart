import 'package:flutter/material.dart';
import 'package:bubbles/components/mode_card.dart';
import 'package:bubbles/components/history_toggle.dart';
import 'package:bubbles/components/bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top icons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: Color(0xFF1A1A1A),
                      size: 24,
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      color: Color(0xFF1A1A1A),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Hi johs,',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.1,
                ),
              ),
              const Text(
                'Choose youre Ai mode',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.1,
                ),
              ),
              const Text(
                'Styles Today',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 32),
              // History toggle
              const HistoryToggle(),
              const SizedBox(height: 24),
              // Mode cards grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: const [
                    ModeCard(
                      title: 'Friends',
                      imagePath: 'assets/images/friends.jpg',
                      backgroundColor: Color(0xFFD4E7F8),
                    ),
                    ModeCard(
                      title: 'your family',
                      imagePath: 'assets/images/family.jpg',
                      backgroundColor: Color(0xFFF5EFE7),
                    ),
                    ModeCard(
                      title: 'lonely',
                      imagePath: 'assets/images/lonely.jpg',
                      backgroundColor: Color(0xFFE8F5E9),
                    ),
                    ModeCard(
                      title: 'just asking',
                      imagePath: 'assets/images/just.jpg',
                      backgroundColor: Color(0xFFFFF9E6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
