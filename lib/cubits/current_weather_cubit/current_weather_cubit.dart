import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weatherly/core/failure/dio_error.dart';
import 'package:weatherly/core/service/internet_service.dart';
import 'package:weatherly/core/service/location_service.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/cubits/current_weather_cubit/current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit({
    required this.weatherService,
    required this.internetService,
  }) : super(WeatherInitial()) {
    _connectionSubscription = internetService.connectionChanges.listen(
      _onConnectionChanged,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Internet connection stream error: $error');
      },
    );
  }

  final WeatherService weatherService;
  final InternetService internetService;
  StreamSubscription<bool>? _connectionSubscription;
  bool? _hasNetworkConnection;
  bool _hasSeenDisconnected = false;
  bool _isRefreshingAfterReconnect = false;
  int _connectionGeneration = 0;
  int _lastRefreshGeneration = 0;

  void _onConnectionChanged(bool isConnected) {
    if (!isConnected) {
      _hasSeenDisconnected = true;
    }

    final reconnected =
        isConnected && _hasNetworkConnection == false && _hasSeenDisconnected;
    _hasNetworkConnection = isConnected;
    if (reconnected) {
      _connectionGeneration++;
      unawaited(_refreshAfterReconnect());
    }
  }

  Future<void> _refreshAfterReconnect() async {
    if (_hasNetworkConnection != true ||
        _isRefreshingAfterReconnect ||
        _connectionGeneration <= _lastRefreshGeneration) {
      return;
    }

    final currentState = state;
    final isOffline = currentState is CurrentWeatherSuccess
        ? currentState.isOffline
        : currentState is CurrentWeatherError && currentState.isOffline;
    if (!isOffline) {
      return;
    }

    _lastRefreshGeneration = _connectionGeneration;
    _isRefreshingAfterReconnect = true;
    try {
      await getWeatherForCurrentLocation(showLoading: false);
    } finally {
      _isRefreshingAfterReconnect = false;
      if (_connectionGeneration > _lastRefreshGeneration) {
        unawaited(_refreshAfterReconnect());
      }
    }
  }

  Future<void> getWeatherForCurrentLocation({bool showLoading = true}) async {
    if (showLoading) {
      emit(CurrentWeatherLoading());
    }
    Position position;
    try {
      position = await LocationService.getCurrentLocation();
    } catch (e) {
      try {
        final cachedWeather = weatherService.getCachedCurrentLocationWeather();
        if (cachedWeather != null) {
          emit(
            CurrentWeatherSuccess(
              weatherEntity: cachedWeather,
              isOffline: true,
            ),
          );
          unawaited(_refreshAfterReconnect());
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
      unawaited(_refreshAfterReconnect());
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
      unawaited(_refreshAfterReconnect());
      return;
    }
    emit(CurrentWeatherError(error: error.toString(), isOffline: isOffline));
    unawaited(_refreshAfterReconnect());
  }

  @override
  Future<void> close() async {
    await _connectionSubscription?.cancel();
    await super.close();
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
