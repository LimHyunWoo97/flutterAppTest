import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkIfPermissionsGranted() async {
  // 요청할 권한 목록
  List<Permission> permissionsToRequest = [
    //await Permission.appTrackingTransparency,
    Permission.location,
    Permission.locationAlways,
    Permission.storage,
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.accessMediaLocation,
  ];

  // 권한 요청 및 상태 확인
  Map<Permission, PermissionStatus> statuses =
      await permissionsToRequest.request();

  // 권한 상태 확인
  bool allPermissionsGranted = true;

  statuses.forEach((permission, permissionStatus) {
    if (permissionStatus.isGranted) {
      log('${permission.toString()} 권한이 부여되었습니다.');
    } else if (permissionStatus.isDenied) {
      log('${permission.toString()} 권한 부여가 거부되었습니다.');
      allPermissionsGranted = false;
    }
  });

  return allPermissionsGranted;
}

Future<bool> requestCameraPermission(BuildContext context) async {
  PermissionStatus status = await Permission.camera.request();

  if (!status.isGranted) {
    // 허용이 안된 경우
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("권한 설정을 확인해주세요."),
            actions: [
              TextButton(
                  onPressed: () {
                    openAppSettings(); // 앱 설정으로 이동
                  },
                  child: Text('설정하기')),
            ],
          );
        });
    return false;
  }
  return true;
}
