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



  
  WeatherEntity( {required this.hours,
    required this.windSpeed,
    required this.airPresure,
    required this.visibility,
    required this.cityName,
    required this.avgTemp,
    required this.humidity,
    required this.days,
  });
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
}
class HourEntity{
  final String? time;
  final String? icon;
  final double? temp;
  final String? description;
  HourEntity({
    required this.time,
    required this.icon,
    required this.temp,
    required this.description
  });
}
