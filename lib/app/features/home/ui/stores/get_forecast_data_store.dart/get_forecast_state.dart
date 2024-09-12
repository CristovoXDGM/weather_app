import 'package:weatherapp/app/features/home/model/forecast_model.dart';

abstract class GetForecastState {}

class InitialGetForecastState extends GetForecastState {}

class LoadingGetForecastState extends GetForecastState {}

class SuccessGetForecastState extends GetForecastState {
  final ForecastModel forecastData;

  SuccessGetForecastState(this.forecastData);
}

class FailureGetForecastState extends GetForecastState {
  final String message;

  FailureGetForecastState({this.message = ""});
}
