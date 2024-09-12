import 'package:flutter/foundation.dart';
import 'package:weatherapp/app/features/home/ui/stores/get_current_location_store/get_current_location_state.dart';

import '../../../data/get_user_current_location.dart';

class GetCurrentLocationStore extends ValueNotifier<GetCurrentLocationState> {
  GetCurrentLocationStore() : super(InitialGetCurrentLocationState());

  final getCurrentLocation = GetUserCurrentLocation();

  Future<void> getLocation() async {
    try {
      value = LoadingGetCurrentLocationState();
      final currentLocation = await getCurrentLocation.getUserLocation();
      value = SuccessGetCurrentLocationState(currentLocation);
    } catch (e, s) {
      debugPrint("StackTrace:$s \nError: $e");
      value = FailureGetCurrentLocationState();
    }
  }
}
