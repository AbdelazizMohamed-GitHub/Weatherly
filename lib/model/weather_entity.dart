// ignore_for_file: public_member_api_docs, sort_constructors_first

class WeatherEntity {
  final String? cityName;
  final double? avgTemp;
  final int? humidity;
  final double? windSpeed;
  final double? airPresure;
  final double? visibility;

  final List<DaysEntity>? days;
  final List<HourEntity>? hours;

  WeatherEntity({
    required this.hours,
    required this.windSpeed,
    required this.airPresure,
    required this.visibility,
    required this.cityName,
    required this.avgTemp,
    required this.humidity,
    required this.days,
  });

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
      cityName: json['cityName'] as String?,
      avgTemp: (json['avgTemp'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      airPresure: (json['airPresure'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      days: (json['days'] as List<dynamic>?)
          ?.map((day) => DaysEntity.fromJson(
                Map<String, dynamic>.from(day as Map),
              ))
          .toList(),
      hours: (json['hours'] as List<dynamic>?)
          ?.map((hour) => HourEntity.fromJson(
                Map<String, dynamic>.from(hour as Map),
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'cityName': cityName,
        'avgTemp': avgTemp,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'airPresure': airPresure,
        'visibility': visibility,
        'days': days?.map((day) => day.toJson()).toList(),
        'hours': hours?.map((hour) => hour.toJson()).toList(),
      };
}

class DaysEntity {
  final String? date;
  final String? icon;
  final double? avgTemp;
  final String? status;

  DaysEntity(
      {required this.date,
      required this.icon,
      required this.avgTemp,
      required this.status});

  factory DaysEntity.fromJson(Map<String, dynamic> json) => DaysEntity(
        date: json['date'] as String?,
        icon: json['icon'] as String?,
        avgTemp: (json['avgTemp'] as num?)?.toDouble(),
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'icon': icon,
        'avgTemp': avgTemp,
        'status': status,
      };
}

class HourEntity {
  final String? time;
  final String? icon;
  final double? temp;
  final String? description;
  HourEntity(
      {required this.time,
      required this.icon,
      required this.temp,
      required this.description});

  factory HourEntity.fromJson(Map<String, dynamic> json) => HourEntity(
        time: json['time'] as String?,
        icon: json['icon'] as String?,
        temp: (json['temp'] as num?)?.toDouble(),
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'icon': icon,
        'temp': temp,
        'description': description,
      };
}
