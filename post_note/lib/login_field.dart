import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final Function(String)? onSubmit;
  final bool obscured;
  final String? Function(String?)? validator;

  const LoginField(
      {super.key,
      required this.hintText,
      this.onSubmit,
      this.obscured = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
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
                color: Color.fromARGB(255, 225, 48, 48),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 225, 48, 48),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Palette.outerSpace),
            errorStyle:
                const TextStyle(color: Color.fromARGB(255, 225, 48, 48))),
      ),
    );
  }
}
