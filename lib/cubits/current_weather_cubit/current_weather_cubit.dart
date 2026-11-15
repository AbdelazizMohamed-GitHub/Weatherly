import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/location_service.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/cubits/current_weather_cubit/current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit({required this.weatherService}) : super(WeatherInitial());
  final WeatherService weatherService;
  getWeatherForCurrentLocation() async {
    emit(CurrentWeatherLoading());
    Position position;
    try {
      position = await LocationService.getCurrentLocation();
    } catch (e) {
      try {
        final cachedWeather = weatherService.getCachedCurrentLocationWeather();
        if (cachedWeather != null) {
          emit(CurrentWeatherSuccess(weatherEntity: cachedWeather));
          return;
        }
      } catch (cacheError) {
        _emitError(cacheError);
        return;
      }

      _emitError(e);
      return;
    }

    try {
      final result = await weatherService.getCurrentLocationWeatherWithStatus(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      emit(
        CurrentWeatherSuccess(
          weatherEntity: result.weather,
          isOffline: result.isFromCache,
        ),
      );
    } catch (e) {
      _emitError(e, isOffline: e is DioException && _isNetworkFailure(e));
    }
  }

  void _emitError(Object error, {bool isOffline = false}) {
    if (error is DioException) {
      emit(
        CurrentWeatherError(
          error: DioExceptions.fromDioError(error).message,
          isOffline: isOffline,
        ),
      );
      return;
    }
    emit(CurrentWeatherError(error: error.toString(), isOffline: isOffline));
  }

  bool _isNetworkFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return true;
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
        return false;
    }
  }
}
