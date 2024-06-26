import 'package:flutter/material.dart';

class AppCustomInput extends StatelessWidget {
  final bool obscureText;
  final bool isMultiLineText;
  final String hintText;
  final String title;
  final String? Function(String?)? validator;
  final bool isTrigerValidate;
  final void Function(String?)? onSave;

  const AppCustomInput(
      {super.key,
      this.obscureText = false,
      this.isMultiLineText = false,
      required this.hintText,
      required this.title,
      required this.isTrigerValidate,
      this.validator,
      this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        maxLines: isMultiLineText ? 2 : 1,
        autovalidateMode: isTrigerValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: title,
            hintText: hintText,
            border: const OutlineInputBorder()),
        style: const TextStyle(color: Colors.black),
        validator: validator,
        onSaved: onSave,
      ),
    );
  }
}
