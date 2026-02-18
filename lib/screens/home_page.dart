import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:bubbles/models/chat.dart';
import 'package:bubbles/models/chat_mode.dart';
import 'package:bubbles/providers/chat_provider.dart';
import 'package:bubbles/theme.dart';
import 'package:bubbles/nav.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyEnabled = ref.watch(historyEnabledProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? DarkModeColors.darkSurfaceVariant : LightModeColors.lightSurfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.help_outline, color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface, size: 24),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? DarkModeColors.darkSurfaceVariant : LightModeColors.lightSurfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share_outlined, color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface, size: 24),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xl),
              Text(
                'Hi johs,',
                style: context.textStyles.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                'Choose youre Ai mode',
                style: context.textStyles.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                'Styles Today',
                style: context.textStyles.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              HistoryToggle(
                isEnabled: historyEnabled,
                onToggle: (value) => ref.read(historyEnabledProvider.notifier).state = value,
              ),
              SizedBox(height: AppSpacing.lg),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  children: ChatMode.values.map((mode) => ChatModeCard(mode: mode)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class HistoryToggle extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const HistoryToggle({super.key, required this.isEnabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? DarkModeColors.darkSurfaceVariant : LightModeColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'History Chat',
            style: context.textStyles.bodyLarge?.semiBold,
          ),
          Switch(
            value: isEnabled,
            onChanged: onToggle,
            activeColor: Colors.green,
            activeTrackColor: Colors.green.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class ChatModeCard extends ConsumerWidget {
  final ChatMode mode;

  const ChatModeCard({super.key, required this.mode});

  Color _getCardColor(ChatMode mode, bool isDark) {
    if (isDark) {
      switch (mode) {
        case ChatMode.friends:
          return DarkModeColors.accentBlue;
        case ChatMode.family:
          return DarkModeColors.accentBeige;
        case ChatMode.lonely:
          return DarkModeColors.accentGreen;
        case ChatMode.justAsking:
          return DarkModeColors.accentYellow;
      }
    } else {
      switch (mode) {
        case ChatMode.friends:
          return LightModeColors.accentBlue;
        case ChatMode.family:
          return LightModeColors.accentBeige;
        case ChatMode.lonely:
          return LightModeColors.accentGreen;
        case ChatMode.justAsking:
          return LightModeColors.accentYellow;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        final newChat = Chat(
          id: const Uuid().v4(),
          mode: mode,
          messages: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        ref.read(chatsProvider.notifier).addChat(newChat);
        ref.read(currentChatProvider.notifier).state = newChat;
        ref.read(chatMessagesProvider.notifier).setMessages([]);
        context.push(AppRoutes.chat, extra: newChat.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getCardColor(mode, isDark),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isDark ? DarkModeColors.darkOutline : LightModeColors.lightOutline,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                image: DecorationImage(
                  image: AssetImage(mode.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              mode.title,
              style: context.textStyles.bodyLarge?.semiBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(AppSpacing.lg),
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Icons.home,
            isSelected: _selectedIndex == 0,
            onTap: () => setState(() => _selectedIndex = 0),
          ),
          _NavItem(
            icon: Icons.person_outline,
            isSelected: _selectedIndex == 1,
            onTap: () => setState(() => _selectedIndex = 1),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark ? DarkModeColors.darkSurface : LightModeColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.settings_outlined,
              color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? (isDark ? DarkModeColors.darkSurface : LightModeColors.lightSurface) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isDark ? DarkModeColors.darkSurface : LightModeColors.lightSurface,
        ),
      ),
    );
  }
}
