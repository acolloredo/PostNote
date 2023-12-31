import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class LoginField extends StatelessWidget {
  final Function(String)? onSubmit;
  final bool obscured;
  final String? hintText;
  final String? initialText;
  final String? Function(String?)? validator;
  final List<String>? autofillHints;

  const LoginField({
    super.key,
    this.initialText,
    this.hintText,
    this.onSubmit,
    this.obscured = false,
    this.validator,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 384.0,
      ),
      child: TextFormField(
        autofillHints: autofillHints,
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
              color: Palette.mint,
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
          hintStyle: const TextStyle(
            color: Palette.outerSpace,
          ),
          errorStyle: const TextStyle(color: Palette.errorColor),
        ),
      ),
    );
  }
}
