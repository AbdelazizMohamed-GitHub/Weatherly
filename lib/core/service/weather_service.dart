import 'package:dio/dio.dart';
import 'package:weatherly/env/env.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/model/weather_mapper.dart';
import 'package:weatherly/model/weather_model.dart';

class WeatherService {
  final Dio dio;
  String baseUrl = "http://api.weatherapi.com/v1";

  WeatherService({required this.dio});

  Future<WeatherEntity> getWeather(String city) async {
    String url =
        "$baseUrl/forecast.json?key=${Env.apiKey}&q=$city&days=7&lang=ar";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return WeatherMapper.mapModelToEntity(
          WeatherModel.fromJson(response.data));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<WeatherEntity> getWeatherForCurrentLocation(
      {required double latitude, required double longitude}) async {
    String url =
        "$baseUrl/forecast.json?key=${Env.apiKey}&q=$latitude,$longitude&days=7&lang=ar";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return WeatherMapper.mapModelToEntity(
          WeatherModel.fromJson(response.data));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  List<String> suggestedPlaces = [];

  // دالة لجلب الأماكن المقترحة باستخدام WeatherAPI
  Future<List<String>> fetchRecommendedPlaces({required String city}) async {
    final response = await dio
        .get("$baseUrl/search.json?key=${Env.apiKey}&q=$city&days=7&lang=ar");

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data; //
      return suggestedPlaces = data
          .map((place) =>
              place['name'].toString()) // الحصول على أسماء المدن من استجابة API
          .toList();
    } else {
      throw Exception('فشل في جلب الأماكن المقترحة');
    }
  }

  // عند اختيار المستخدم اقتراحًا
  void _onPlaceSelected(String place) {
    // المتابعة لجلب بيانات الطقس للمكان المختار
    print('المكان المختار: $place');
  }
}
