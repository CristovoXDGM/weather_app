import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/app/features/home/data/get_weather_type.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_state.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_data_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_state.dart';

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
    final sizer = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.login,
            color: Colors.red.withOpacity(0.5),
          ),
          onPressed: () {
            context.pushReplacement("/");
            authService.logOut();
          },
        ),
      ),
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

              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  physics: sizer.width < 820
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      CurrentWeatherComponent(
                        sizer: sizer,
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
              );
            }

            if (state is FailureGetForecastState) {
              return const Center(
                child: Text("Please, check if your location service is enabled"),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
