import 'package:flutter/material.dart';
import 'package:weatherly/model/weather_entity.dart';

class CustomHourDetails extends StatelessWidget {
  const CustomHourDetails({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: weather.hours!.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: 130,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  weather.hours![index].time!.substring(11, 16),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Image.network(
                    "https:${weather.hours![index].icon}",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${weather.hours![index].temp}°C',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
