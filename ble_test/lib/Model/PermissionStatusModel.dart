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
