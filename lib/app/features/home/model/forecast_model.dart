import 'current_weather_model.dart';
import 'hourly_weather_model.dart';

class ForecastModel {
  final CurrentWeatherModel current;
  final HourlyWeatherModel hourly;

  ForecastModel({required this.current, required this.hourly});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      current: CurrentWeatherModel.fromJson(json['current']),
      hourly: HourlyWeatherModel.fromJson(json['hourly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current.toJson(),
      'hourly': hourly.toJson(),
    };
  }
}
