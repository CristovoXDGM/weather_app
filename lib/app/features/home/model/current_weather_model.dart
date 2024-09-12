class CurrentWeatherModel {
  final String time;
  final double temperature;
  final double windSpeed;
  final double precipitation;
  final int weatherCode;

  final int isDay;

  CurrentWeatherModel(
      {required this.time,
      required this.temperature,
      required this.windSpeed,
      required this.isDay,
      required this.precipitation,
      required this.weatherCode});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
        time: json['time'],
        temperature: json['temperature_2m'],
        isDay: json['is_day'],
        windSpeed: json['wind_speed_10m'],
        precipitation: json['precipitation'],
        weatherCode: json['weather_code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature,
      'wind_speed_10m': windSpeed,
      'precipitation': precipitation,
      'is_day': isDay,
      'weather_code': weatherCode,
    };
  }
}
