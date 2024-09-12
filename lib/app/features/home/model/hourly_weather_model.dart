class HourlyWeatherModel {
  final List<String> time;
  final List<double> windSpeed;
  final List<double> temperature;
  final List<double> precipitation;
  final List<int> weatherCode;

  HourlyWeatherModel({
    required this.time,
    required this.windSpeed,
    required this.temperature,
    required this.precipitation,
    required this.weatherCode,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: List<String>.from(json['time']),
      windSpeed: List<double>.from(
        json['wind_speed_10m'].map(
          (speed) {
            if (speed != null) {
              return double.parse(speed.toString());
            }
          },
        ),
      ),
      temperature: List<double>.from(
        json['temperature_2m'].map(
          (temperature) {
            if (temperature != null) {
              return temperature;
            }
          },
        ),
      ),
      precipitation: List<double>.from(
        json['precipitation'].map(
          (precipitation) {
            if (precipitation != null) {
              return precipitation;
            }
          },
        ),
      ),
      weatherCode: List<int>.from(
        json['weather_code'].map(
          (precipitation) {
            if (precipitation != null) {
              return precipitation;
            }
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'wind_speed_10m': windSpeed,
      'temperature_2m': temperature,
      'precipitation': precipitation,
      'weather_code': weatherCode,
    };
  }
}
