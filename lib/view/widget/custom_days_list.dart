// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weatherly/model/weather_entity.dart';

class CustomDaysList extends StatelessWidget {
  const CustomDaysList({
    super.key,
    required this.weather,
  });
  final WeatherEntity weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: weather.days!.length - 1,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "${weather.days![index + 1].icon}",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Text(
                '${weather.days![index + 1].avgTemp}°',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0),
              ),
              Column(
                children: [
                  Text(
                    '${weather.days![index + 1].status}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24.0),
                  ),
                  Text(
                    '${weather.days![index + 1].date}',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
