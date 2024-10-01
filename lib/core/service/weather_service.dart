import 'package:dio/dio.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/model/weather_mapper.dart';
import 'package:weatherly/model/weather_model.dart';

class WeatherService {
 final Dio dio ;
  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "8bbac42755bb4f52ab2161355242901";

  WeatherService({required this.dio});

  Future<WeatherEntity> getWeather(String city) async {
    String url = "$baseUrl/forecast.json?key=$apiKey&q=$city&days=7&lang=ar";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return WeatherMapper.mapModelToEntity(
          WeatherModel.fromJson(response.data));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<WeatherEntity> getWeatherForCurrentLocation( {required double latitude,required double longitude})async {

 String url = "$baseUrl/forecast.json?key=$apiKey&q=$latitude,$longitude&days=7&lang=ar";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return WeatherMapper.mapModelToEntity(
          WeatherModel.fromJson(response.data));
    } else {
      throw Exception('Failed to load weather');
    }

  }
}
