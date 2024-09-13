import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherapp/app/features/home/data/get_weather_type.dart';

import '../../model/current_weather_model.dart';

class CurrentWeatherComponent extends StatefulWidget {
  const CurrentWeatherComponent(
      {super.key,
      required this.sizer,
      required this.weatherType,
      required this.forecastData,
      required this.date,
      required this.dayName});

  final Size sizer;

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
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.weatherType.getColor(widget.forecastData.isDay),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      height: widget.sizer.height * 0.65,
      width: widget.sizer.width,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
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
              height: 80,
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
          ],
        ),
      ),
    );
  }
}
