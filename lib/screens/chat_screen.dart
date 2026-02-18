import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:bubbles/models/message.dart';
import 'package:bubbles/providers/chat_provider.dart';
import 'package:bubbles/theme.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chat = ref.read(chatsProvider.notifier).getChatById(widget.chatId);
      if (chat != null) {
        ref.read(chatMessagesProvider.notifier).setMessages(chat.messages);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final chat = ref.read(chatsProvider.notifier).getChatById(widget.chatId);
    if (chat == null) return;

    _messageController.clear();
    ref.read(chatMessagesProvider.notifier).sendMessage(content, chat.mode, widget.chatId);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final chat = ref.watch(chatsProvider.notifier).getChatById(widget.chatId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (chat == null) {
      return Scaffold(
        body: Center(child: Text('Chat not found', style: context.textStyles.bodyLarge)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          chat.mode.title,
          style: context.textStyles.titleLarge?.semiBold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: isDark ? DarkModeColors.darkOnSurfaceVariant : LightModeColors.lightOnSurfaceVariant,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Text(
                          'Start a conversation',
                          style: context.textStyles.titleMedium?.copyWith(
                            color: isDark ? DarkModeColors.darkOnSurfaceVariant : LightModeColors.lightOnSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          chat.mode.description,
                          style: context.textStyles.bodyMedium?.copyWith(
                            color: isDark ? DarkModeColors.darkOnSurfaceVariant : LightModeColors.lightOnSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: AppSpacing.paddingMd,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => MessageBubble(message: messages[index]),
                  ),
          ),
          MessageInput(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeFormat = DateFormat('HH:mm');

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSpacing.md),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: message.isUser
                    ? (isDark ? DarkModeColors.darkPrimary : LightModeColors.lightPrimary)
                    : (isDark ? DarkModeColors.darkSurfaceVariant : LightModeColors.lightSurfaceVariant),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg),
                  topRight: Radius.circular(AppRadius.lg),
                  bottomLeft: message.isUser ? Radius.circular(AppRadius.lg) : Radius.zero,
                  bottomRight: message.isUser ? Radius.zero : Radius.circular(AppRadius.lg),
                ),
              ),
              child: Text(
                message.content,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: message.isUser
                      ? (isDark ? DarkModeColors.darkOnPrimary : LightModeColors.lightOnPrimary)
                      : (isDark ? DarkModeColors.darkOnSurface : LightModeColors.lightOnSurface),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              timeFormat.format(message.timestamp),
              style: context.textStyles.bodySmall?.copyWith(
                color: isDark ? DarkModeColors.darkOnSurfaceVariant : LightModeColors.lightOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInput({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? DarkModeColors.darkSurface : LightModeColors.lightSurface,
        border: Border(
          top: BorderSide(
            color: isDark ? DarkModeColors.darkOutline : LightModeColors.lightOutline,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? DarkModeColors.darkSurfaceVariant : LightModeColors.lightSurfaceVariant,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: context.textStyles.bodyMedium?.copyWith(
                      color: isDark ? DarkModeColors.darkOnSurfaceVariant : LightModeColors.lightOnSurfaceVariant,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
                  ),
                  style: context.textStyles.bodyMedium,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => onSend(),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? DarkModeColors.darkPrimary : LightModeColors.lightPrimary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: isDark ? DarkModeColors.darkOnPrimary : LightModeColors.lightOnPrimary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
