import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/custom_color.dart';

class ActionInputBarWidget extends StatefulWidget {
  final Function(File)? onImageCaptured;
  final Function(Map<String, dynamic>)? onVoiceRecorded;

  const ActionInputBarWidget({
    super.key,
    this.onImageCaptured,
    this.onVoiceRecorded,
  });

  @override
  State<ActionInputBarWidget> createState() => _ActionInputBarWidgetState();
}

class _ActionInputBarWidgetState extends State<ActionInputBarWidget>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  int _seconds = 0;
  Timer? _timer;

  late AnimationController _pulseController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _seconds = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
    if (widget.onVoiceRecorded != null && _seconds > 0) {
      widget.onVoiceRecorded!({"duration": _seconds.toString()});
    }
  }

  void _cancelRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _seconds = 0;
    });
  }

  String _formatTime(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return "$m:$sec";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E24),
        border: Border.all(
          color: _isRecording
              ? Colors.red
              : const Color(0xff86CC55).withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: _isRecording
          ? Row(
        children: [
          GestureDetector(
            onTap: _cancelRecording,
            child: const Icon(Icons.close, color: Colors.red),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                FadeTransition(
                  opacity: _pulseController,
                  child: const Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "RECORDING... ${_formatTime(_seconds)}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: _stopRecording,
            child: AnimatedScale(
              scale: 1.1,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.stop,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () async {
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (image != null && widget.onImageCaptured != null) {
                    widget.onImageCaptured!(File(image.path));
                  }
                },
                child: const Icon(
                  Icons.camera_alt,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: _startRecording,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic,
                color: AppColors.black,
                size: 28,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery);
                  if (image != null && widget.onImageCaptured != null) {
                    widget.onImageCaptured!(File(image.path));
                  }
                },
                child: const Icon(
                  Icons.photo_library,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}