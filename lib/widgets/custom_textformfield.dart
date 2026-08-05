import 'package:flutter/material.dart';

class CustomTextFromField extends StatefulWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.prefixIcon,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int maxLines;

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      obscureText: widget.isPassword ? hidePassword : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),

        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
