import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherly/core/service/weather_cache_service.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/model/weather_entity.dart';

void main() {
  late Directory tempDirectory;
  late Box<String> box;
  late WeatherCacheService cacheService;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp('weather-cache-');
    Hive.init(tempDirectory.path);
    box = await Hive.openBox<String>('weather');
    cacheService = WeatherCacheService(box: box);
  });

  tearDown(() async {
    await box.close();
    await Hive.close();
    await tempDirectory.delete(recursive: true);
  });

  test('persists and restores current and forecast weather', () async {
    final weather = _weather();

    await cacheService.saveWeather(
      WeatherCacheService.currentLocationKey,
      weather,
    );

    final restored = cacheService.getCurrentLocationWeather();
    expect(restored?.cityName, weather.cityName);
    expect(restored?.avgTemp, weather.avgTemp);
    expect(restored?.days?.single.date, weather.days?.single.date);
    expect(restored?.days?.single.avgTemp, weather.days?.single.avgTemp);
    expect(restored?.hours?.single.time, weather.hours?.single.time);
    expect(
        restored?.hours?.single.description, weather.hours?.single.description);
  });

  test('uses cached city weather when the request has a connection error',
      () async {
    final weather = _weather();
    await cacheService.saveWeather(cacheService.cityKey('Cairo'), weather);

    final service = WeatherService(
      dio: _offlineDio(),
      cacheService: cacheService,
    );

    final result = await service.getWeather(' cairo ');

    expect(result.cityName, weather.cityName);
    expect(result.hours?.single.temp, weather.hours?.single.temp);
  });

  test('uses cached location weather when the request has a connection error',
      () async {
    final weather = _weather();
    await cacheService.saveWeather(
      WeatherCacheService.currentLocationKey,
      weather,
    );
    final service = WeatherService(
      dio: _offlineDio(),
      cacheService: cacheService,
    );

    final result = await service.getWeatherForCurrentLocation(
      latitude: 30.0,
      longitude: 31.0,
    );

    expect(result.cityName, weather.cityName);
  });
}

Dio _offlineDio() {
  return Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.connectionError,
            ),
          );
        },
      ),
    );
}

WeatherEntity _weather() => WeatherEntity(
      cityName: 'Cairo',
      avgTemp: 25.5,
      humidity: 40,
      windSpeed: 5.2,
      airPresure: 1012.0,
      visibility: 10.0,
      days: [
        DaysEntity(
          date: '2026-10-18',
          icon: 'https://example.com/day.png',
          avgTemp: 26.0,
          status: 'Sunny',
        ),
      ],
      hours: [
        HourEntity(
          time: '2026-10-18 15:00',
          icon: 'https://example.com/hour.png',
          temp: 25.5,
          description: 'Clear',
        ),
      ],
    );
