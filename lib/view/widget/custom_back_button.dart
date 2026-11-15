import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color = Colors.white,
    this.size = 25,
  });

  final VoidCallback? onPressed;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
        size: size,
      ),
    );
  }
}
