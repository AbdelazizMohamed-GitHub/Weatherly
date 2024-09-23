
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/model/weather_model.dart';

class WeatherMapper {
  static WeatherEntity mapModelToEntity(WeatherModel weatherModel) {
    List<DaysEntity> dayEntities =
        weatherModel.forecast!.forecastday!.map((forecastDay) {
      return DaysEntity(
        date: forecastDay.date,
        avgTemp: forecastDay.day!.avgtempC,
        status: forecastDay.day!.condition!.text,
        icon:
            "https:${forecastDay.day!.condition!.icon}", // Ensuring valid icon URL
      );
    }).toList();
    List<HourEntity> hourEntities = weatherModel.forecast!.forecastday!.expand((forecastDay) {
  return forecastDay.hour!.map((hourData) {
    return HourEntity(
      time: hourData.time,                     // Time for the hour
      temp: hourData.tempC,                    // Temperature for the hour
      icon: hourData.condition!.icon,          // Icon for the weather condition
      description: hourData.condition!.text,   // Description for the weather condition
    );
  }).toList();  // Flatten the list to avoid nested lists
}).toList(); 
   

    return WeatherEntity(
        days: dayEntities,
        cityName: weatherModel.location!.name,
        humidity: weatherModel.current!.humidity,
        avgTemp: weatherModel.current!.tempC,
        windSpeed: weatherModel.current!.windMph,
        airPresure: weatherModel.current!.pressureMb,
        visibility: weatherModel.current!.visKm,
        hours: hourEntities);
  }
}
