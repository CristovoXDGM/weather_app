import 'package:location/location.dart';

abstract class GetCurrentLocationState {}

class InitialGetCurrentLocationState extends GetCurrentLocationState {}

class LoadingGetCurrentLocationState extends GetCurrentLocationState {}

class SuccessGetCurrentLocationState extends GetCurrentLocationState {
  final LocationData location;

  SuccessGetCurrentLocationState(this.location);
}

class FailureGetCurrentLocationState extends GetCurrentLocationState {}
