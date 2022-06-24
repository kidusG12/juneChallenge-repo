import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType textKeyboardType;
  final String label;
  final String? Function(String?) fieldValidator;
  final bool isPassword;

TextField({
    required this.textController,
    required this.fieldValidator,
    required this.label,
    required this.textKeyboardType,
    this.isPassword = false,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: fieldValidator,
      controller:textController,
      textInputAction: TextInputAction.next,
      keyboardType: textKeyboardType,
      obscureText: isPassword,
      decoration:InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
