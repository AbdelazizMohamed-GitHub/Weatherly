// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weatherly/core/utils/app_color.dart';

import 'package:weatherly/model/weather_entity.dart';

class CustomDaysCurrentDay extends StatelessWidget {
  const CustomDaysCurrentDay({
    super.key,
    required this.weather,
  });
final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Container(
                                height: 150.0,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        AppColor.sColor,
                                        AppColor.pColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network(
                                    "${weather.days![0].icon}",
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${weather.days![0].avgTemp}°C',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26.0),
                                        ),
                                        Text(
                                          '${weather.days![0].status}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
  }
}
