import 'package:geolocator/geolocator.dart';

class GetUserCurrentLocation {
  late bool _serviceEnabled;

  late LocationPermission _permissionStatus;

  Future<Position> getUserLocation() async {
    final locationData = await Geolocator.getCurrentPosition();

    return locationData;
  }

  Future<bool> checkLocationService() async {
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        return false;
      }
      return _serviceEnabled;
    }
    return false;
  }

  Future<void> checkPermissions() async {
    _permissionStatus = await Geolocator.checkPermission();
    if (_permissionStatus == LocationPermission.denied) {
      _permissionStatus = await Geolocator.requestPermission();
      if (_permissionStatus != LocationPermission.always ||
          _permissionStatus != LocationPermission.whileInUse) {
        return;
      }
    }
  }
}
