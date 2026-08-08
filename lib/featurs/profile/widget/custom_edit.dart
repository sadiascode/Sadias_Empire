import 'package:flutter/material.dart';
import '../../../common/custom_color.dart';

class CustomEdit extends StatefulWidget {
  final String title;
  final String? hintText;
  final Color fillColor;
  final TextEditingController? controller;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final Function(String?)? onDropdownChanged;

  const CustomEdit({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.fillColor = Colors.transparent,
    this.dropdownItems,
    this.selectedValue,
    this.onDropdownChanged,
  });

  @override
  State<CustomEdit> createState() => _CustomEditState();
}

class _CustomEditState extends State<CustomEdit> {
  String? _internalSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 6),

        TextField(
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
            ),
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary, width: 2)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}