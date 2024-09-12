import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/app/features/home/model/forecast_model.dart';

abstract class IGetForecastData {
  Future<ForecastModel> call(double lat, double long);
}

class GetForecastData implements IGetForecastData {
  @override
  Future<ForecastModel> call(double lat, double long) async {
    try {
      final url = Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current=precipitation,temperature_2m,wind_speed_10m&hourly=precipitation,temperature_2m,wind_speed_10m",
      );

      final response = await http.get(url);

      if (response.statusCode.toString().startsWith("2")) {
        final decodedData = jsonDecode(response.body);

        final convertedValue = ForecastModel.fromJson(decodedData);
        return convertedValue;
      }

      throw Exception("Something went wrong, try again");
    } catch (e) {
      rethrow;
    }
  }
}
