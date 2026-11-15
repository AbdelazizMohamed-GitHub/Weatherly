import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weatherly/model/weather_entity.dart';

class WeatherCacheService {
  WeatherCacheService({required Box<String> box}) : _box = box;

  static const String currentLocationKey = 'current_location';

  final Box<String> _box;

  Future<void> saveWeather(String key, WeatherEntity weather) async {
    try {
      await _box.put(key, jsonEncode(weather.toJson()));
    } catch (error) {
      debugPrint('Unable to cache weather for "$key": $error');
    }
  }

  WeatherEntity? getWeather(String key) {
    final cachedWeather = _box.get(key);
    if (cachedWeather == null) {
      return null;
    }

    final decoded = jsonDecode(cachedWeather);
    if (decoded is! Map) {
      throw const FormatException('Cached weather data must be a JSON object');
    }

    return WeatherEntity.fromJson(Map<String, dynamic>.from(decoded));
  }

  WeatherEntity? getCurrentLocationWeather() => getWeather(currentLocationKey);

  String cityKey(String city) => 'city_${city.trim().toLowerCase()}';
}
