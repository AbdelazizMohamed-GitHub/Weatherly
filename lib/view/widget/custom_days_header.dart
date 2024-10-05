import 'package:flutter/material.dart';

import 'package:weatherly/model/weather_entity.dart';

class CustomDaysHeader extends StatelessWidget {
  const CustomDaysHeader({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        const Spacer(flex: 1),
        Column(
          children: [
            Text('${weather.cityName}',
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(
              '${weather.days?[0].date}',
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ],
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
