// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/view/home_screen.dart';

class CustomSplashButton extends StatelessWidget {
  const CustomSplashButton({
    super.key,
    required this.ontap,
  });
final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: ontap,
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
