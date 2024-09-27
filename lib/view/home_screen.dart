// ignore_for_file: prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_cubit.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_state.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/core/utils/app_image.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/days_screen.dart';
import 'package:weatherly/view/search_screen.dart';
import 'package:weatherly/view/widget/custom_degree_item.dart';
import 'package:weatherly/view/widget/loading_.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherEntity? weather;
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is CurrentWeatherSuccess) {
          weather = state.weatherEntity;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state is CurrentWeatherLoading
                ? Loading()
                : state is CurrentWeatherError
                    ?Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.error),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<WeatherCubit>(context).getWeatherForCurrentLocation();  
                        }
                        , child: Text('Retry')
                      )
                    ],
                  )
                    : Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(179, 243, 238,
                                  238), // Lighter blue (sky blue)
                              AppColor.sColor, // Darker blue (ocean blue)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Column(
                                  children: [
                                    Text('${weather!.cityName}',
                                        style: TextStyle(fontSize: 24.0)),
                                    Text('${weather!.avgTemp}°C',
                                        style: TextStyle(fontSize: 18.0)),
                                  ],
                                ),
                                Spacer(),
                                IconButton(padding: EdgeInsets.zero,
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SearchScreen(),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(
                              height: 250,
                              child: Swiper(
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        top: 25,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white70,
                                                    AppColor.pColor,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.center),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10),
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
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '${weather!.days![index].status}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white),
                                        child: Text(
                                          '${weather!.days![index].date}',
                                          style: TextStyle(
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
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomDegreeItem(
                                        image: AppImage.humidity,
                                        number: '${weather!.humidity}%',
                                        title: 'Humidity'),
                                    CustomDegreeItem(
                                        image: AppImage.wind,
                                        number: '${weather!.windSpeed} km/h',
                                        title: 'Wind'),
                                    CustomDegreeItem(
                                        image: AppImage.speedometer,
                                        number: '${weather!.airPresure}',
                                        title: 'Air Pressure'),
                                    CustomDegreeItem(
                                        image: AppImage.visibility,
                                        number: '${weather!.visibility}km',
                                        title: 'Visibility'),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DaysScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          'See Next 7 Days',
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: weather!.hours!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      width: 130,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            weather!.hours![index].time!
                                                .substring(11, 16),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Image.network(
                                              "https:${weather!.hours![index].icon}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${weather!.hours![index].temp}°C',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}
