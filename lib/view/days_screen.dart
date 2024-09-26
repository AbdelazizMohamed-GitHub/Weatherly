// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_cubit.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_state.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/model/weather_entity.dart';

class DaysScreen extends StatelessWidget {
  const DaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherEntity? weather;
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeatherForCurrentLocation(),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherSuccess) {
            weather = state.weatherEntity;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is WeatherLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is WeatherError
                    ? Center(
                        child: Text(state.error),
                      )
                    : SafeArea(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: const [
                                AppColor.sColor, // Lighter blue (sky blue)
                                AppColor.pColor, // Darker blue (ocean blue)
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Spacer(flex: 1),
                                    Column(
                                      children: [
                                        Text('${weather!.cityName}',
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        Text(
                                          '${weather?.days?[0].date}',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Spacer(flex: 1),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: const [
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
                                      "${weather!.days![0].icon}",
                                        height: 150,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${weather?.days![0].avgTemp}°C',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26.0),
                                          ),
                                          Text(
                                            '${weather?.days![0].status}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(32)),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: weather!.days!.length-1,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider();
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            "${weather!.days![index+1].icon}",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          Text(
                                            '${weather?.days![index+1].avgTemp}°',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28.0),
                                          ),
                                          Column(
                                            children:  [
                                              Text(
                                                '${weather?.days![index+1].status}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 24.0),
                                              ),
                                              Text(
                                                '${weather?.days![index+1].date}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
