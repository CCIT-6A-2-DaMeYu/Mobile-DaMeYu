
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const ButtonLogin({
    super.key, 
    required this.title, 
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColor().pinkColor,
      padding: const EdgeInsets.symmetric(horizontal: 130.0, vertical: 15.0),
      ),
      onPressed: onPressed, 
      child: Text(
        'Login',
        style: ThemeTextStyle().login,
      ),
    );
  }
}