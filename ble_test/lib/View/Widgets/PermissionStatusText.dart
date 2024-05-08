// ignore_for_file: non_constant_identifier_names

import 'package:app_test/Model/PermissionStatusModel.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionStatusText extends StatefulWidget {
  const PermissionStatusText({super.key});

  @override
  State<PermissionStatusText> createState() => _PermissionStatusTextState();
}

class _PermissionStatusTextState extends State<PermissionStatusText> {
  PermissionStatus _location_permissionStatus = PermissionStatus.denied;
  PermissionStatus _bluetooth_permissionStatus = PermissionStatus.denied;
  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    PermissionStatus locationstatus = await Permission.location.status;
    PermissionStatus bluetoothstatus = await Permission.bluetooth.status;
    setState(() {
      _location_permissionStatus = locationstatus;
      _bluetooth_permissionStatus = bluetoothstatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    PermissionStatusModel permissionStatusModel = PermissionStatusModel();

    switch (_location_permissionStatus) {
      case PermissionStatus.granted:
        permissionStatusModel.locationPermission =
            'Location permission granted';
        break;
      case PermissionStatus.denied:
        permissionStatusModel.locationPermission = 'Location permission denied';
        break;
      case PermissionStatus.restricted:
        permissionStatusModel.locationPermission =
            'Location permission restricted';
        break;
      default:
        permissionStatusModel.locationPermission = 'Unknown permission status';
    }
    switch (_bluetooth_permissionStatus) {
      case PermissionStatus.granted:
        permissionStatusModel.bluetoothPermission =
            'Bluetooth permission granted';
        break;
      case PermissionStatus.denied:
        permissionStatusModel.bluetoothPermission =
            'Bluetooth permission denied';
        break;
      case PermissionStatus.restricted:
        permissionStatusModel.bluetoothPermission =
            'Bluetooth permission restricted';
        break;
      default:
        permissionStatusModel.bluetoothPermission = 'Unknown permission status';
    }

    return Center(
      child: Column(
        children: [
          Text('${permissionStatusModel.locationPermission}'),
          Text('${permissionStatusModel.bluetoothPermission}'),
        ],
      ),
    );
  }
}
