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
      emit(CityWeatherError(error: "برجاء المحاولة مرة اخرى"));
    }
  }

  Future<void> getRecommendedPlace({required String cityName}) async {
    if (cityName.trim().isEmpty) {
      emit(FetchRecommendedLocationSuccess(suggestedPlaces: const []));
      return;
    }

    emit(FetchRecommendedLocationLoading());
    try {
      final places = await weatherService.fetchRecommendedPlaces(
        city: cityName,
      );
      emit(FetchRecommendedLocationSuccess(suggestedPlaces: places));
    } on DioException catch (error) {
      final isNetworkFailure = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
          true,
        _ => false,
      };
      emit(
        FetchRecommendedLocationError(
          error: isNetworkFailure
              ? 'لا يوجد اتصال بالإنترنت'
              : DioExceptions.fromDioError(error).message,
        ),
      );
    } catch (error) {
      emit(FetchRecommendedLocationError(error: error.toString()));
    }
  }
}
