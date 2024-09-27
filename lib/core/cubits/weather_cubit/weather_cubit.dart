// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_state.dart';
import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/location_service.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/model/weather_entity.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void getWeather({required String cityName}) async {
    try {
      emit(CityWeatherLoading());
      WeatherEntity weather = await WeatherService().getWeather(cityName);
      emit(CityWeatherSuccess(weatherEntity: weather));
    } catch (e) {
      if (e is DioException) {
      print("11111111111111${DioExceptions.fromDioError(e).message}");

        return emit(CityWeatherError(error: DioExceptions.fromDioError(e).message));
      }
      emit(CityWeatherError(error: "Something went wrong"));
    }
  }

  getWeatherForCurrentLocation() async {
    try {
      emit(CurrentWeatherLoading());
      Position position = await LocationService.getCurrentLocation();
      print("latitude: ${position.latitude} longitude: ${position.longitude}");
      WeatherEntity weather = await WeatherService()
          .getWeatherForCurrentLocation(
              latitude: position.latitude, longitude: position.longitude);
      emit(CurrentWeatherSuccess(weatherEntity: weather));
    } catch (e) {
      print("11111111111111${e.toString()}");
      if (e is DioException) {
        return emit(CurrentWeatherError(error: DioExceptions.fromDioError(e).message));
      }

      emit(CurrentWeatherError(error: e.toString()));
    }
  }
}
