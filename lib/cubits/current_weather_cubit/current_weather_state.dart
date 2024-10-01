import 'package:weatherly/model/weather_entity.dart';

class CurrentWeatherState {}

class WeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherSuccess extends CurrentWeatherState {
  final WeatherEntity weatherEntity;

  CurrentWeatherSuccess( {required this.weatherEntity});

}

class CurrentWeatherError extends CurrentWeatherState {
  final String error; 

  CurrentWeatherError({required this.error});
}

