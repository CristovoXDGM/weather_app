class ForecastModel {
  final CurrentWeather current;
  final HourlyWeather hourly;

  ForecastModel({required this.current, required this.hourly});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      current: CurrentWeather.fromJson(json['current']),
      hourly: HourlyWeather.fromJson(json['hourly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current.toJson(),
      'hourly': hourly.toJson(),
    };
  }
}

class CurrentWeather {
  final String time;
  final double temperature;
  final double windSpeed;
  final double precipitation;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.windSpeed,
    required this.precipitation,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'],
      temperature: json['temperature_2m'],
      windSpeed: json['wind_speed_10m'],
      precipitation: json['precipitation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature,
      'wind_speed_10m': windSpeed,
      'precipitation': precipitation,
    };
  }
}

class HourlyWeather {
  final List<String> time;
  final List<double> windSpeed;
  final List<double> temperature;
  final List<double> precipitation;

  HourlyWeather({
    required this.time,
    required this.windSpeed,
    required this.temperature,
    required this.precipitation,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'wind_speed_10m': windSpeed,
      'temperature_2m': temperature,
      'precipitation': precipitation,
    };
  }
}
