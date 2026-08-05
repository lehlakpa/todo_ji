import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.blue,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.alignment = Alignment.center,
  });

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
