import 'package:dio/dio.dart';
import 'package:weatherly/env/env.dart';
import 'package:weatherly/core/service/weather_cache_service.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/model/weather_mapper.dart';
import 'package:weatherly/model/weather_model.dart';

class WeatherService {
  final Dio dio;
  final WeatherCacheService cacheService;

  static const String baseUrl = 'https://api.weatherapi.com/v1';

  WeatherService({required this.dio, required this.cacheService});

  /// جلب توقعات الطقس باستخدام الموقع الجغرافي
  Future<WeatherEntity> getWeatherForCurrentLocation({
    required double latitude,
    required double longitude,
  }) async =>
      (await getCurrentLocationWeatherWithStatus(
        latitude: latitude,
        longitude: longitude,
      ))
          .weather;

  Future<WeatherFetchResult> getCurrentLocationWeatherWithStatus({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/forecast.json',
        queryParameters: {
          'key': Env.apiKey,
          'q': '$latitude,$longitude',
          'days': 7,
          'lang': 'ar',
        },
      );

      final weather = _parseWeather(response);
      await cacheService.saveWeather(
        WeatherCacheService.currentLocationKey,
        weather,
      );
      return WeatherFetchResult(weather: weather, isFromCache: false);
    } on DioException catch (error) {
      if (!_isNetworkFailure(error)) {
        rethrow;
      }
      final cachedWeather = cacheService.getCurrentLocationWeather();
      if (cachedWeather != null) {
        return WeatherFetchResult(weather: cachedWeather, isFromCache: true);
      }
      rethrow;
    }
  }

  Future<List<String>> fetchRecommendedPlaces({
    required String city,
  }) async {
    if (city.trim().isEmpty) {
      return [];
    }

    final response = await dio.get(
      '$baseUrl/search.json',
      queryParameters: {
        'key': Env.apiKey,
        'q': city.trim(),
      },
    );

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;

      return data
          .map(
            (place) => place['name'].toString(),
          )
          .toList();
    }

    throw Exception('فشل في جلب الأماكن المقترحة');
  }

  /// جلب توقعات الطقس باستخدام اسم المدينة
  Future<WeatherEntity> getWeather(String city) async {
    final cacheKey = cacheService.cityKey(city);
    try {
      final response = await dio.get(
        '$baseUrl/forecast.json',
        queryParameters: {
          'key': Env.apiKey,
          'q': city,
          'days': 7,
          'lang': 'ar',
        },
      );

      final weather = _parseWeather(response);
      await cacheService.saveWeather(cacheKey, weather);
      return weather;
    } on DioException catch (error) {
      if (!_isNetworkFailure(error)) {
        rethrow;
      }
      final cachedWeather = cacheService.getWeather(cacheKey);
      if (cachedWeather != null) {
        return cachedWeather;
      }
      rethrow;
    }
  }

  WeatherEntity? getCachedCurrentLocationWeather() =>
      cacheService.getCurrentLocationWeather();

  bool _isNetworkFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return true;
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
        return false;
    }
  }

  /// تحويل استجابة API إلى WeatherEntity
  WeatherEntity _parseWeather(Response response) {
    if (response.statusCode == 200) {
      return WeatherMapper.mapModelToEntity(
        WeatherModel.fromJson(
          response.data as Map<String, dynamic>,
        ),
      );
    }

    throw Exception('فشل في تحميل بيانات الطقس');
  }

  /// البحث عن المدن والأماكن المقترحة
}

class WeatherFetchResult {
  const WeatherFetchResult({
    required this.weather,
    required this.isFromCache,
  });

  final WeatherEntity weather;
  final bool isFromCache;
}
