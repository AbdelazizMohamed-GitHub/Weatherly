import 'package:flutter/material.dart';

import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/days_screen.dart';

class CustomShowNextDays extends StatelessWidget {
  const CustomShowNextDays({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DaysScreen(
                  weather: weather,
                ),
              ),
            );
          },
          child: const Row(
            children: [
              Text(
                'عرض الايام المتاحة',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        )
      ],
    );
  }
}
