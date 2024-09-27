import 'package:weatherly/model/weather_entity.dart';

class WeatherState {}

class WeatherInitial extends WeatherState {}

class CurrentWeatherLoading extends WeatherState {}

class CurrentWeatherSuccess extends WeatherState {
  final WeatherEntity weatherEntity;

  CurrentWeatherSuccess( {required this.weatherEntity});

}

class CurrentWeatherError extends WeatherState {
  final String error; 

  CurrentWeatherError({required this.error});
}

class CityWeatherLoading extends WeatherState{}
class CityWeatherSuccess extends WeatherState{
  final WeatherEntity weatherEntity;

  CityWeatherSuccess( {required this.weatherEntity});
}
class CityWeatherError extends WeatherState{
  final String error;

  CityWeatherError({required this.error});
}
