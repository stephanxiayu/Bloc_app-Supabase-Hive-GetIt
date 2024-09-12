import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonString;
  final VoidCallback onPressed;
  const AuthGradientButton(
      {super.key, required this.buttonString, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppPallete.gradient1, AppPallete.gradient2])),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(390, 55),
            shadowColor: AppPallete.transparentColor,
            backgroundColor: AppPallete.transparentColor),
        onPressed: onPressed,
        child: Text(
          buttonString,
          style: const TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
