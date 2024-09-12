import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_state.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_data_store.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_forecast_data_store.dart/get_forecast_state.dart';
import 'package:weatherapp/app/shared/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getCurrentLocationStore = GetCurrentLocationStore();

  final getForecastStore = GetForecastDataStore();

  @override
  void initState() {
    super.initState();

    getCurrentLocationStore.getLocation();

    getCurrentLocationStore.addListener(() {
      final state = getCurrentLocationStore.value;

      if (state is SuccessGetCurrentLocationState) {
        getForecastStore.getForecastData(
          state.location.latitude!,
          state.location.longitude!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.sunny.withOpacity(0.3),
      body: ValueListenableBuilder(
          valueListenable: getForecastStore,
          builder: (context, state, child) {
            if (state is SuccessGetForecastState) {
              final format = DateFormat("dd/MM/yyyy");

              final date = DateTime.parse(state.forecastData.current.time);

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.sunny,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60)),
                      ),
                      height: sizer.height * 0.65,
                      width: sizer.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${state.forecastData.current.temperature.toStringAsFixed(0)} C",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 90,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${format.format(date)} ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      child: SizedBox(
                        width: sizer.width,
                        height: sizer.height * 0.25,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.forecastData.hourly.temperature.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 80,
                              width: 80,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              color: AppColors.sunny,
                              child: Text(
                                "${state.forecastData.hourly.temperature[index].toStringAsFixed(0)} C",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: sizer.height,
                      width: double.infinity,
                      color: AppColors.sunny.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
