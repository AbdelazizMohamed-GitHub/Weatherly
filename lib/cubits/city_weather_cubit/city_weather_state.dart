part of 'city_weather_cubit.dart';

sealed class CityWeatherState {}

final class CityWeatherInitial extends CityWeatherState {}
class CityWeatherLoading extends CityWeatherState{}
class CityWeatherSuccess extends CityWeatherState{
  final WeatherEntity weatherEntity;

  CityWeatherSuccess( {required this.weatherEntity});
}
class CityWeatherError extends CityWeatherState{
  final String error;

  CityWeatherError({required this.error});
}
