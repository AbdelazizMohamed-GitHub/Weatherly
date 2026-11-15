import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherly/core/service/app_setting_servise.dart';

import 'package:weatherly/core/service/weather_cache_service.dart';
import 'package:weatherly/core/service/weather_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await Hive.initFlutter();

  final weatherBox = await Hive.openBox<String>('weather');
  final settingsBox = await Hive.openBox('settings');

  getIt.registerLazySingleton<WeatherCacheService>(
    () => WeatherCacheService(box: weatherBox),
  );

  getIt.registerLazySingleton<WeatherService>(
    () => WeatherService(
      dio: Dio(),
      cacheService: getIt<WeatherCacheService>(),
    ),
  );

  getIt.registerLazySingleton<AppSettingsService>(
    () => AppSettingsService(box: settingsBox),
  );
}
