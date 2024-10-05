import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/core/utils/app_image.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/view/home_screen.dart';
import 'package:weatherly/view/widget/custom_splash_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.sColor, // Lighter blue (sky blue)
              AppColor.pColor, // Darker blue (ocean blue)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather Icon - Replace with an asset image if you have one
              SvgPicture.asset(
                AppImage.weatherIcon,
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 30),
              // App Title
              const Text(
                'Weather Now',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Tagline
              const Text(
                'Your Forecast, Simplified',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 50),
              CustomSplashButton(
                onPressed: () {
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }),
                  );
                  login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
