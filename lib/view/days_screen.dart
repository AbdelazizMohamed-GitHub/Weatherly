

import 'package:flutter/material.dart';

import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/widget/custom_days_current.dart';
import 'package:weatherly/view/widget/custom_days_header.dart';
import 'package:weatherly/view/widget/custom_days_list.dart';

class DaysScreen extends StatelessWidget {
  const DaysScreen({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.sColor, // Lighter blue (sky blue)
                AppColor.pColor, // Darker blue (ocean blue)
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                CustomDaysHeader(weather: weather),
                const SizedBox(
                  height: 20.0,
                ),
                CustomDaysCurrentDay(weather: weather),
                const SizedBox(
                  height: 20.0,
                ),
                CustomDaysList(weather: weather)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
