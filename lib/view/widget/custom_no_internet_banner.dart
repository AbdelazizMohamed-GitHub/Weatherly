import 'package:flutter/material.dart';

class CustomNoInternetBanner extends StatelessWidget {
  const CustomNoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFFB3261E),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            'لا يوجد اتصال بالإنترنت',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
