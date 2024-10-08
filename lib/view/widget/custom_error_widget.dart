import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )),
          TextButton(
              onPressed: onPressed,
              child: const Text(
                'ءاعادة المحاولة',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }
}
