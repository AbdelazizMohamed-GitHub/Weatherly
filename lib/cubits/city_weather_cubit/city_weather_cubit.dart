import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/model/weather_entity.dart';

part 'city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit({required this.weatherService})
      : super(CityWeatherInitial());
  final WeatherService weatherService;
  void getCityWeather({required String cityName}) async {
    try {
      emit(CityWeatherLoading());
      WeatherEntity weather = await weatherService.getWeather(cityName);
      emit(CityWeatherSuccess(weatherEntity: weather));
    } catch (e) {
      if (e is DioException) {
        return emit(
            CityWeatherError(error: DioExceptions.fromDioError(e).message));
      }
      emit(CityWeatherError(error: "Something went wrong"));
    }
  }

  Future<void> getRecommendedPlace(
      {required String cityName})async {
    emit(FetchRecommendedLocationLoading());
  try {
     await weatherService
        .fetchRecommendedPlaces(city: cityName,)
        .then((value) {
          emit(FetchRecommendedLocationSuccess(suggestedPlaces: value));
        });
  // ignore: empty_catches
  } catch (e) {
   
    
  }
  }
}
