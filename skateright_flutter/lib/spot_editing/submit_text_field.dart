import 'package:flutter/material.dart';

class SubmitTextField extends StatelessWidget {
  SubmitTextField({Key? key, required this.label, required this.controller})
      : super(key: key);

  final String label;
  final TextEditingController controller;

  OutlineInputBorder _outlineBorderStyle({Color? borderColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: borderColor ??= const Color(0xFF94B321)));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xFF94B321),
      textCapitalization: TextCapitalization.words,
      controller: controller,
      decoration: InputDecoration(
        border: _outlineBorderStyle(),
        enabledBorder: _outlineBorderStyle(),
        focusedBorder: _outlineBorderStyle(),
        errorBorder: _outlineBorderStyle(borderColor: const Color(0xFFEB001B)),
        focusedErrorBorder: _outlineBorderStyle(borderColor: const Color(0xFFEB001B)),
        disabledBorder: _outlineBorderStyle(borderColor: Colors.grey[700]),

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
