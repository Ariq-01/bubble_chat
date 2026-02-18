import 'package:flutter/material.dart';

class HistoryToggle extends StatefulWidget {
  const HistoryToggle({super.key});

  @override
  State<HistoryToggle> createState() => _HistoryToggleState();
}

class _HistoryToggleState extends State<HistoryToggle> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'History Chat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              setState(() {
                isEnabled = value;
              });
            },
            activeColor: const Color(0xFF4CAF50),
            activeTrackColor: const Color(0xFF4CAF50).withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
