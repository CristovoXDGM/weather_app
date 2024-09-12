import 'package:flutter/material.dart';
import 'package:weatherapp/app/shared/constants/app_colors.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {super.key, required this.controller, required this.label, this.hideText = false});

  final TextEditingController controller;
  final String label;
  final bool hideText;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        hintText: "Enter your ${widget.label}",
        label: Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.cloudy,
          ),
        ),
      ),
      obscureText: widget.hideText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your ${widget.label}";
        }
        return null;
      },
    );
  }
}
