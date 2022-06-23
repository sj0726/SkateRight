import 'package:flutter/material.dart';

class SubmitTextField extends StatelessWidget {
  SubmitTextField({Key? key, required this.label, required this.controller}) : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xFF94B321),
      textCapitalization: TextCapitalization.words,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF94B321))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF94B321))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF94B321))),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFf0e6d0)),
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Color(0xFFf0e6d0),
          ),
          onPressed: () => controller.clear(),
        ),
      ),
    );
  }
}
