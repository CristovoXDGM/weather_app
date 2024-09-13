import 'package:geolocator/geolocator.dart';

abstract class GetCurrentLocationState {}

class InitialGetCurrentLocationState extends GetCurrentLocationState {}

class LoadingGetCurrentLocationState extends GetCurrentLocationState {}

class SuccessGetCurrentLocationState extends GetCurrentLocationState {
  final Position location;

  SuccessGetCurrentLocationState(this.location);
}

class FailureGetCurrentLocationState extends GetCurrentLocationState {}
