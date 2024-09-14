import 'dart:ui';

import 'package:weatherapp/app/shared/assets/assets_svgs.dart';
import 'package:weatherapp/app/shared/constants/app_colors.dart';

class GetWeatherType {
  WeatherType getWeatherType(
    int weatherCode,
  ) {
    if (weatherCode == 0) {
      return WeatherType.clear;
    }
    if (weatherCode > 0 && weatherCode < 71) {
      return WeatherType.cloudy;
    }
    if (weatherCode >= 71 && weatherCode < 95) {
      return WeatherType.snowy;
    }
    if (weatherCode >= 95) {
      return WeatherType.storm;
    }

    return WeatherType.clear;
  }
}

enum WeatherType {
  clear,
  cloudy,
  snowy,
  storm;

  Color getColor([int? isDay]) {
    if (this == WeatherType.cloudy) {
      return AppColors.cloudy;
    }
    if (this == WeatherType.snowy) {
      return AppColors.snowy;
    }
    if (this == WeatherType.storm) {
      return AppColors.night;
    }

    return AppColors.dayLight;
  }

  String getIcon() {
    if (this == WeatherType.cloudy) {
      return AssetsSvgs.clearClouds;
    }
    if (this == WeatherType.snowy) {
      return AssetsSvgs.snowClouds;
    }
    if (this == WeatherType.storm) {
      return AssetsSvgs.stormCloud;
    }
    return AssetsSvgs.clearDay;
  }
}
