import 'package:dameyu_project/theme/theme_color.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      color: ThemeColor().pink2Color,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: child,
      ),
    );
  }
}