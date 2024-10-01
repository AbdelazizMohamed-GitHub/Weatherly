import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weatherly/core/service/weather_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register services or classes
  getIt.registerLazySingleton<WeatherService>(() => WeatherService(dio: Dio()));
 
}