import 'package:flutter/material.dart';
import 'package:post_note/palette.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final Function(String) onSubmit;

  const LoginField({super.key, required this.hintText, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        onFieldSubmitted: onSubmit,
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
          hintText: hintText,
          hintStyle: const TextStyle(color: Palette.outerSpace),
        ),
      ),
    );
  }
}
