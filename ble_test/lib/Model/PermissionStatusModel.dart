// ignore_for_file: unnecessary_this

class PermissionStatusModel {
  static final PermissionStatusModel _instance =
      PermissionStatusModel._internal();

  String? bluetoothPermission;
  String? locationPermission;

  factory PermissionStatusModel() {
    return _instance;
  }

  PermissionStatusModel._internal() {
    this.bluetoothPermission = '';
    this.locationPermission = '';
  }
}
