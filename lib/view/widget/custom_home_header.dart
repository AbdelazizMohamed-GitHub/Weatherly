import 'package:flutter/material.dart';

import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/search_screen.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
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
        isHome
            ? const Spacer(flex: 1)
            : Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
        const Spacer(
          flex: 2,
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
        isHome
            ? IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
              )
            : const Spacer(
                flex: 1,
              ),
        const SizedBox(width: 10),
      ],
    );
  }
}
