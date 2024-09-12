import 'package:location/location.dart';

class GetUserCurrentLocation {
  final _location = Location();

  late bool _serviceEnabled;

  late PermissionStatus _permissionStatus;

  Future<LocationData> getUserLocation() async {
    _serviceEnabled = await _location.serviceEnabled();

    final locationData = await _location.getLocation();

    return locationData;
  }

  Future<bool> checkLocationService() async {
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
      return _serviceEnabled;
    }
    return false;
  }

  Future<void> checkPermissions() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
  }
}
