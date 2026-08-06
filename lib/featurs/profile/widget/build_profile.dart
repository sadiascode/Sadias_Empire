import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';

Widget BuildProfile(
    IconData icon,
    String title,
    String value,
    )
{
  return ListTile(
    leading: Icon(icon, color: AppColors.secondary),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.textMuted,
          size: 12,
        ),
      ],
    ),
    onTap: () {},
  );
}