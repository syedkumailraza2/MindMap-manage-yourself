import 'package:flutter/material.dart';
import 'package:mindmap/Theme/theme.dart';

class InputFields extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final Icon? icon;

  const InputFields({
    super.key,
    required this.controller,
    this.label,
    this.icon,
  });

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        const SizedBox(height: 6),
        Container(
          width: screenWidth * 0.8,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              prefixIcon: widget.icon, // <-- Correct way to add an icon
              filled: true,
              fillColor: Colors.white,
              iconColor: AppColors.primary,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
