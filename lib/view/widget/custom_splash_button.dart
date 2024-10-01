import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/view/home_screen.dart';

class CustomSplashButton extends StatelessWidget {
  const CustomSplashButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }),
                  );
                },
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