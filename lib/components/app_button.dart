import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btnName;
  final TextStyle btnTxtStyle;
  final ButtonStyle btnStyle;

// In this Initializer List is used after Constructor(:)
  AppButton({
    super.key,
    required this.onPressed,
    required this.btnName,
    this.btnTxtStyle =
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ButtonStyle? btnStyle,
  }) : btnStyle = btnStyle ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
            );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: btnStyle,
      child: Text(
        btnName,
        style: btnTxtStyle,
      ),
    );
  }
}
