// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/widget/custom_error_widget.dart';
import 'package:weatherly/view/widget/custom_loading.dart';
import 'package:weatherly/view/widget/custom_sccess_body.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({
    super.key,
    required this.city,
  });
  final String city;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityWeatherCubit(weatherService: getIt.get<WeatherService>())
            ..getCityWeather(cityName: city),
      child: BlocBuilder<CityWeatherCubit, CityWeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: state is CityWeatherLoading
                  ? const CustomLoading()
                  : state is CityWeatherError
                      ? CustomError(
                          onPressed: () {
                            if (city.isNotEmpty) {
                              BlocProvider.of<CityWeatherCubit>(context)
                                  .getCityWeather(cityName: city);
                            }
                          },
                          text: state.error)
                      : state is CityWeatherSuccess
                          ? CustomSccessBody(
                              weather: state.weatherEntity,
                              isHome: false,
                            )
                          : const Text("البحث عن مدينة"),
            ),
          );
        },
      ),
    );
  }
}
