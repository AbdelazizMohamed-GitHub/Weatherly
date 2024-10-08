import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';

import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/widget/custom_home_header.dart';
import 'package:weatherly/view/widget/custom_hour_details.dart';
import 'package:weatherly/view/widget/custom_show_next_days.dart';
import 'package:weatherly/view/widget/custom_sweper_list.dart';
import 'package:weatherly/view/widget/custom_weather_details.dart';

class CustomSccessBody extends StatelessWidget {
  const CustomSccessBody({
    super.key,
    required this.weather,
    this.isHome = true,
  });
  final WeatherEntity weather;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(179, 243, 238, 238), // Lighter blue (sky blue)
            AppColor.sColor, // Darker blue (ocean blue)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
         const SizedBox(height: 20,),
          CustomHeader(
            weather: weather,
            isHome: isHome,
          ),
          Expanded(
          flex: 2,
            child: CustomSweperList(weather: weather),
          ),
          Expanded(flex: 1,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
             
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomWetherDetails(weather: weather),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomShowNextDays(weather: weather),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(flex: 2,
            child: CustomHourDetails(weather: weather)),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
