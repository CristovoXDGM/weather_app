import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/app/features/home/data/get_weather_type.dart';

import '../../model/current_weather_model.dart';

class CurrentWeatherComponent extends StatefulWidget {
  const CurrentWeatherComponent(
      {super.key,
      required this.weatherType,
      required this.forecastData,
      required this.date,
      required this.dayName});

  final WeatherType weatherType;
  final CurrentWeatherModel forecastData;

  final String date;
  final String dayName;
  @override
  State<CurrentWeatherComponent> createState() => _CurrentWeatherComponentState();
}

class _CurrentWeatherComponentState extends State<CurrentWeatherComponent> {
  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.sizeOf(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.weatherType.getColor(widget.forecastData.isDay),
          borderRadius: sizer.width <= 840
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                )
              : null,
        ),
        height: sizer.width < 820 ? sizer.width * 0.80 : sizer.height,
        width: sizer.width < 820 ? sizer.width : sizer.width * 0.3,
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              Text(
                "${widget.forecastData.temperature.toStringAsFixed(0)}ºC",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 90,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                widget.weatherType.getIcon(),
                height: 90,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.date,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.dayName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      );
    });
  }
}
