import 'package:app_test/View/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionStatusText extends StatefulWidget {
  const PermissionStatusText({super.key});

  @override
  State<PermissionStatusText> createState() => _PermissionStatusTextState();
}

class _PermissionStatusTextState extends State<PermissionStatusText> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    PermissionStatus locationstatus = await Permission.location.status;
    PermissionStatus bluetoothstatus = await Permission.bluetooth.status;
    setState(() {
      _permissionStatus = locationstatus;
      _permissionStatus = bluetoothstatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    String location_permissionText = '';
    String bluetooth_permissionText = '';

    switch (_permissionStatus) {
      case PermissionStatus.granted:
        location_permissionText = 'Location permission granted';
        bluetooth_permissionText = 'Bluetooth permission granted';
        break;
      case PermissionStatus.denied:
        location_permissionText = 'Location permission denied';
        bluetooth_permissionText = 'Bluetooth permission denied';
        break;
      case PermissionStatus.restricted:
        location_permissionText = 'Location permission restricted';
        bluetooth_permissionText = 'Bluetooth permission restricted';
        break;
      default:
        location_permissionText = 'Unknown permission status';
        bluetooth_permissionText = 'Unknown permission status';
    }

    return Center(
      child: Column(
        children: [
          Text(location_permissionText),
          Text(bluetooth_permissionText),
        ],
      ),
    );
  }
}
