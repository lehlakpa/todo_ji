import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 12,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
