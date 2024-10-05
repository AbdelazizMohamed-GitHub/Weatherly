import 'package:flutter/material.dart';

import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/search_screen.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({
    super.key,
    required this.weather,
    required this.isHome,
  });
  final WeatherEntity weather;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        Column(
          children: [
            Text('${weather.cityName}', style: const TextStyle(fontSize: 24.0)),
            Text('${weather.avgTemp}°C',
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
        const Spacer(
          flex: 2,
        ),
     isHome?   IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
        ):const Spacer(flex: 1,),
        const SizedBox(width: 10),
      ],
    );
  }
}
