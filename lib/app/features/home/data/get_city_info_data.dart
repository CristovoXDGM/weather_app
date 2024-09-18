import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

abstract class IGetCityInfoData {
  Future<dynamic> getCityData(String cityName);
}

class GetCityInfoData implements IGetCityInfoData {
  final baseUrl = "https://geocoding-api.open-meteo.com/v1/search";

  @override
  Future getCityData(String cityName) async {
    try {
      final url = Uri.parse(
        "$baseUrl?name=$cityName&count=10&language=en",
      );
      final response = await http.get(url);

      final decodedData = jsonDecode(response.body);

      debugPrint("Retrived data $decodedData");
    } catch (e) {
      debugPrint("Error $e");
    }
  }
}
