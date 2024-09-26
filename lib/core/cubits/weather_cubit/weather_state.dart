import 'package:weatherly/model/weather_entity.dart';

class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final WeatherEntity weatherEntity;

  WeatherSuccess( {required this.weatherEntity});

}

class WeatherError extends WeatherState {
  final String error; 

  WeatherError({required this.error});
}
