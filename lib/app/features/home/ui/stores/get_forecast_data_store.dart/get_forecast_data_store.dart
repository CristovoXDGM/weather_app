import 'package:flutter/material.dart';

import '../../../data/get_forecast_data.dart';
import 'get_forecast_state.dart';

class GetForecastDataStore extends ValueNotifier<GetForecastState> {
  GetForecastDataStore() : super(InitialGetForecastState());

  final getForecast = GetForecastData();

  void getForecastData(double lat, double long) async {
    try {
      value = LoadingGetForecastState();
      final result = await getForecast(lat, long);
      value = SuccessGetForecastState(result);
    } on Exception catch (e, s) {
      debugPrint("StackTrace:$s \nError: $e");
      value = FailureGetForecastState();
    }
  }
}
