import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';

class ChartBar extends StatelessWidget {
  final double height;
  final String month;

  const ChartBar({
    super.key,
    required this.height,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.secondary,
                Color(0xFF7C2D12),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          month,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}