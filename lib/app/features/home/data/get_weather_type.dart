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
    if (weatherCode > 71 && weatherCode < 95) {
      return WeatherType.snowy;
    }
    if (weatherCode > 95) {
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

    return isDay != null && isDay == 1 ? AppColors.dayLight : AppColors.night;
  }

  String getIcon() {
    if (this == WeatherType.cloudy) {
      return AssetsSvgs.cloudy;
    }
    if (this == WeatherType.snowy) {
      return AssetsSvgs.snowy;
    }
    if (this == WeatherType.storm) {
      return AssetsSvgs.clearNight;
    }
    return AssetsSvgs.clearDay;
  }
}
