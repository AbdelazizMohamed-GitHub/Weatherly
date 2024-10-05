import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/cubits/current_weather_cubit/current_weather_cubit.dart';
import 'package:weatherly/cubits/current_weather_cubit/current_weather_state.dart';
import 'package:weatherly/view/widget/custom_error_widget.dart';
import 'package:weatherly/view/widget/custom_sccess_body.dart';
import 'package:weatherly/view/widget/custom_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CurrentWeatherCubit(weatherService: getIt.get<WeatherService>())
            ..getWeatherForCurrentLocation(),
      child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: state is CurrentWeatherLoading
                  ? const CustomLoading()
                  : state is CurrentWeatherError
                      ? CustomError(
                          onPressed: () {
                            BlocProvider.of<CurrentWeatherCubit>(context)
                                .getWeatherForCurrentLocation();
                          },
                          text: state.error)
                      : state is CurrentWeatherSuccess
                          ? CustomSccessBody(weather: state.weatherEntity)
                          : const SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
