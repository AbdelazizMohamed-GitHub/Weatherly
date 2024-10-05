import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';

class CustomSplashButton extends StatelessWidget {
  const CustomSplashButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: onPressed,
      color: AppColor.pColor,
      textColor: Colors.white,
      minWidth: 200,
      height: 50,
      child: const Text(
        'Get Started',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
