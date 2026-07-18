import 'dart:io';
import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';
import 'action_input_bar_widget.dart';

class CustomText extends StatefulWidget {
  final TextEditingController messageController;
  final Function(String) onSend;
  final Function(Map<String, dynamic>)? onVoiceRecorded;
  final Function(File)? onImageCaptured;

  const CustomText({
    super.key,
    required this.messageController,
    required this.onSend,
    this.onVoiceRecorded,
    this.onImageCaptured,
  });

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  Map<String, dynamic>? _stagedRecording;

  void _handleSend() {
    if (_stagedRecording != null) {
      if (widget.onVoiceRecorded != null) {
        widget.onVoiceRecorded!(_stagedRecording!);
      }
      setState(() {
        _stagedRecording = null;
      });
    } else if (widget.messageController.text.trim().isNotEmpty) {
      widget.onSend(widget.messageController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF121215),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _stagedRecording != null
                      ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      children: [
                        Icon(Icons.mic, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          "Voice Recording (${_stagedRecording!['duration']}s)",
                          style: const TextStyle(color: Color(0xff86CC55), fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _stagedRecording = null;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                      : TextField(
                    controller: widget.messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Chat with Sadia.....',
                      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _handleSend,
                  icon:  Icon(Icons.send, color: AppColors.primary, size: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ActionInputBarWidget(
            onImageCaptured: widget.onImageCaptured,
            onVoiceRecorded: (voice) {
              setState(() {
                _stagedRecording = voice;
              });
            },
          ),
        ],
      ),
    );
  }
}