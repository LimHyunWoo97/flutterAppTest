import 'dart:developer';

import 'package:app_test/View/SplashScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissoinButton extends StatefulWidget {
  const PermissoinButton({super.key});

  @override
  State<PermissoinButton> createState() => _PermissoinButtonState();
}

class _PermissoinButtonState extends State<PermissoinButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.18, 5,
            MediaQuery.of(context).size.width * 0.18, 5),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.lightBlue,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1, 1))
            ]),
        child: AutoSizeText(
          '권한 요청하기',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NaNumBarumGothic',
          ),
          presetFontSizes: [18, 15, 13],
        ),
      ),
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Request Permission"),
              content: FutureBuilder<bool>(
                future: checkIfPermissionsGranted(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.data == true) {
                      return Text("Permission granted!"); // 권한이 허용된 경우
                    } else {
                      return Text("Permission denied!"); // 권한이 거부된 경우
                    }
                  }
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

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
