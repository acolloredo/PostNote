import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class LoginField extends StatelessWidget {
  final Function(String)? onSubmit;
  final bool obscured;
  final String? hintText;
  final String? initialText;
  final String? Function(String?)? validator;

  const LoginField({
    super.key,
    this.initialText,
    this.hintText,
    this.onSubmit,
    this.obscured = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onSubmit,
        obscureText: obscured,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.outerSpace,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.outerSpace,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.errorColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.errorColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Palette.outerSpace),
          errorStyle: const TextStyle(color: Palette.errorColor),
        ),
      ),
    );
  }
}
