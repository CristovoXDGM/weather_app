import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/app/features/home/data/get_weather_type.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_state.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_data_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_state.dart';

import '../../../../../shared/services/responsive_sizer.dart';
import '../../../../login/data/auth_service.dart';
import '../../components/current_weather_component.dart';
import '../../components/hourly_weather_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getCurrentLocationStore = GetCurrentLocationStore();
  final authService = AuthService();
  final getForecastStore = GetForecastDataStore();

  @override
  void initState() {
    super.initState();

    // GetCityInfoData().getCityData("maceio");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getAuthStatus();

      authService.isAuthenticated.addListener(() {
        if (!authService.isAuthenticated.value) {
          if (context.mounted) {
            context.go("/");
          }
        } else {
          getCurrentLocationStore.getLocation();

          getCurrentLocationStore.addListener(() {
            final state = getCurrentLocationStore.value;

            if (state is SuccessGetCurrentLocationState) {
              getForecastStore.getForecastData(
                state.location.latitude,
                state.location.longitude,
              );
            }

            if (state is FailureGetCurrentLocationState) {
              getForecastStore.value = FailureGetForecastState();
            }
          });
        }
      });
    });

    getCurrentLocationStore.getLocation();

    getCurrentLocationStore.addListener(() {
      final state = getCurrentLocationStore.value;

      if (state is SuccessGetCurrentLocationState) {
        getForecastStore.getForecastData(
          state.location.latitude,
          state.location.longitude,
        );
      }

      if (state is FailureGetCurrentLocationState) {
        getForecastStore.value = FailureGetForecastState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.sizeOf(context);
    final screenType = ResponsiveSizer().getScreenType(sizer.width);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.login,
      //       color: Colors.red.withOpacity(0.5),
      //     ),
      //     onPressed: () {
      //       context.pushReplacement("/");
      //       authService.logOut();
      //     },
      //   ),
      // ),
      body: ValueListenableBuilder(
          valueListenable: getForecastStore,
          builder: (context, state, child) {
            if (state is SuccessGetForecastState) {
              final format = DateFormat("dd/MM\nHH:mm");
              final dateNameFormat = DateFormat("EEEE");
              final forecastCurrentData = state.forecastData.current;
              final forecastHourlyData = state.forecastData.hourly;

              final date = DateTime.parse(forecastCurrentData.time).toLocal();

              final currentWeatherType = GetWeatherType().getWeatherType(
                state.forecastData.current.weatherCode,
              );

              return Container(
                height: sizer.height,
                width: sizer.width,
                color: currentWeatherType.getColor().withOpacity(0.3),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SingleChildScrollView(
                    child: screenType == ScreenType.expanded
                        ? Row(
                            children: [
                              Column(
                                children: [
                                  CurrentWeatherComponent(
                                    weatherType: currentWeatherType,
                                    date: "${format.format(date)} ",
                                    dayName: dateNameFormat.format(date),
                                    forecastData: forecastCurrentData,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  HourlyWeatherComponent(
                                    sizer: sizer,
                                    currentWeatherType: currentWeatherType,
                                    hourlyWeatherData: forecastHourlyData,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              CurrentWeatherComponent(
                                weatherType: currentWeatherType,
                                date: "${format.format(date)} ",
                                dayName: dateNameFormat.format(date),
                                forecastData: forecastCurrentData,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              HourlyWeatherComponent(
                                sizer: sizer,
                                currentWeatherType: currentWeatherType,
                                hourlyWeatherData: forecastHourlyData,
                              ),
                            ],
                          ),
                  ),
                ),
              );
            }

            if (state is FailureGetForecastState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Please, check if your location service is enabled",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        getCurrentLocationStore.getLocation();
                      },
                      child: const Text("Refresh page"),
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
