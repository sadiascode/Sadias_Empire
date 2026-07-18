import 'dart:io';
import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';
import '../widget/custom_text.dart';

class ChatScreen extends StatefulWidget {
  final bool isActive;
  const ChatScreen ({super.key, this.isActive = false});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [

  ];


  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "sender": "user",
        "text": text,
        "type": "text",
      });
    });

    _messageController.clear();


    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "Hello, I'm Sadia. How may I assist you today?",
          "type": "text",
        });
      });
      _scrollToBottom();
    });
  }

  void _sendImageMessage(File image) {
    setState(() {
      _messages.add({
        "sender": "user",
        "type": "image",
        "imagePath": image.path,
      });
    });
    _scrollToBottom();
  }

  void _sendVoiceMessage(dynamic voice) {
    setState(() {
      _messages.add({
        "sender": "user",
        "type": "voice",
        "duration": "3",
      });
    });
    _scrollToBottom();
  }

  Future<void> _fetchChatHistory() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF121215),
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                final type = msg['type'];

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.primary
                          : const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(12),
                      border: isUser
                          ? null
                          : Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: type == "image"
                        ? Image.file(
                      File(msg['imagePath']),
                      width: 200,
                    )
                        : type == "voice"
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.play_arrow, color: Colors.white),
                        SizedBox(width: 6),
                        Text("Voice Message", style: TextStyle(color: Colors.white)),
                      ],
                    )
                        : Text(
                      msg['text'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomText(
                messageController: _messageController,
                onSend: (text) {
                  _sendMessage(text);
                },
                onVoiceRecorded: (voice) {
                  _sendVoiceMessage(voice);
                },
                onImageCaptured: (file) {
                  _sendImageMessage(file);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}