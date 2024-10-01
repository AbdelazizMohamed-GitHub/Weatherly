import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/model/weather_entity.dart';

part 'city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit() : super(CityWeatherInitial());
    void getCityWeather({required String cityName}) async {
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
}
