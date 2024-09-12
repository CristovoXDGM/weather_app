import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../data/get_weather_type.dart';
import '../../model/hourly_weather_model.dart';

class HourlyWeatherComponent extends StatefulWidget {
  const HourlyWeatherComponent(
      {super.key,
      required this.sizer,
      required this.hourlyWeatherData,
      required this.currentWeatherType});

  final Size sizer;
  final HourlyWeatherModel hourlyWeatherData;
  final WeatherType currentWeatherType;

  @override
  State<HourlyWeatherComponent> createState() => _HourlyWeatherComponentState();
}

class _HourlyWeatherComponentState extends State<HourlyWeatherComponent> {
  final format = DateFormat("dd/MM\nHH:mm");
  final dateNameFormat = DateFormat("EEEE");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.sizer.width,
      height: widget.sizer.width < 820 ? widget.sizer.height * 0.25 : widget.sizer.height,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.sizer.width < 820 ? 1 : 6,
            childAspectRatio: 4 / 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          scrollDirection: widget.sizer.width < 820 ? Axis.horizontal : Axis.vertical,
          itemCount: widget.hourlyWeatherData.temperature.length,
          itemBuilder: (context, index) {
            final hourlyDateTime = DateTime.parse(
              widget.hourlyWeatherData.time[index],
            );
            final hourlyWeatherType = GetWeatherType().getWeatherType(
              widget.hourlyWeatherData.weatherCode[index],
            );
            return ClipRRect(
              child: Container(
                padding: const EdgeInsets.all(18),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: widget.currentWeatherType.getColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FittedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "${widget.hourlyWeatherData.temperature[index].toStringAsFixed(0)}ºC",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          hourlyWeatherType.getIcon(),
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        format.format(hourlyDateTime),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white.withOpacity(
                            0.7,
                          ),
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        dateNameFormat.format(hourlyDateTime),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white.withOpacity(
                            0.7,
                          ),
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
