import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final onChanged;

  const CustomTextField({super.key, required this.controller, this.prefixIcon,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        prefixIcon: prefixIcon,
      ),
      onChanged: onChanged,
    );
  }
}