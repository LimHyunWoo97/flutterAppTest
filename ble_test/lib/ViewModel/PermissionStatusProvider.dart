import 'package:app_test/Model/PermissionStatusModel.dart';
import 'package:flutter/material.dart';

class PermissionStatusProvider extends ChangeNotifier {
  late PermissionStatusModel _permissionStatusModel;

  // ignore: non_constant_identifier_names
  PermissionStatusProvider() {
    _permissionStatusModel = PermissionStatusModel();
  }

  String? getLocationStatus() {
    return _permissionStatusModel.locationPermission;
  }

  setLocationStatus(String? _locationPermission) {
    _permissionStatusModel.locationPermission = _locationPermission;
    notifyListeners();
  }

  String? getBluetoothStatus() {
    return _permissionStatusModel.locationPermission;
  }

  setBluetoothStatus(String? _bluetoothPermission) {
    _permissionStatusModel.bluetoothPermission = _bluetoothPermission;
    notifyListeners();
  }
}
