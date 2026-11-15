import 'package:weatherly/model/weather_entity.dart';

class CurrentWeatherState {}

class WeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherSuccess extends CurrentWeatherState {
  final WeatherEntity weatherEntity;
  final bool isOffline;

  CurrentWeatherSuccess({
    required this.weatherEntity,
    this.isOffline = false,
  });

}

class CurrentWeatherError extends CurrentWeatherState {
  final String error; 
  final bool isOffline;

  CurrentWeatherError({
    required this.error,
    this.isOffline = false,
  });
}
