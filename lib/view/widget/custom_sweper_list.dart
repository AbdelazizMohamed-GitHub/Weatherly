import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/model/weather_entity.dart';

class CustomSweperList extends StatelessWidget {
  const CustomSweperList({super.key, required this.weather});
  final WeatherEntity? weather;
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.white70,
                      AppColor.pColor,
                    ], begin: Alignment.topCenter, end: Alignment.center),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Image.network(
                      "${weather!.days![index].icon}",
                      width: 150,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${weather!.days![index].avgTemp}°C',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${weather!.days![index].status}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Text(
                '${weather!.days![index].date}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
      itemCount: weather!.days!.length,
      viewportFraction: 0.7,
      scale: 0.8,
    );
  }
}
