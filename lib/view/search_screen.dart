import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/widget/custom_error_widget.dart';
import 'package:weatherly/view/widget/custom_sccess_body.dart';
import 'package:weatherly/view/widget/custom_search.dart';
import 'package:weatherly/view/widget/custom_loading.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String city = '';
    return BlocProvider(
      create: (context) =>
          CityWeatherCubit(weatherService: getIt.get<WeatherService>()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomSearch(
                onChanged: (String value) {
                  city = value;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<CityWeatherCubit, CityWeatherState>(
                builder: (context, state) {
                  return state is CityWeatherLoading
                      ? const Expanded(child: CustomLoading())
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
                              ? Expanded(
                                  child: CustomSccessBody(
                                    weather: state.weatherEntity,
                                    isHome: false,
                                  ),
                                )
                              : const Text(
                                  'Search Result',
                                  style: TextStyle(color: Colors.black),
                                );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
