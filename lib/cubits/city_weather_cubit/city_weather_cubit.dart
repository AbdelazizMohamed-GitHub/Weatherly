// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/model/weather_entity.dart';

part 'city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit(
    {required this.weatherService}
  ) : super(CityWeatherInitial());
  final WeatherService weatherService;
    void getCityWeather({required String cityName}) async {
    try {
      emit(CityWeatherLoading());
      WeatherEntity weather = await weatherService.getWeather(cityName);
      emit(CityWeatherSuccess(weatherEntity: weather));
    } catch (e) {
      if (e is DioException) {
      print("11111111111111${DioExceptions.fromDioError(e).message}");

        return emit(CityWeatherError(error: DioExceptions.fromDioError(e).message));
      }
      emit(CityWeatherError(error: "Something went wrong"));
    }
  }
}
