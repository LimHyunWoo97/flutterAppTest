import 'package:app_test/View/Widgets/BleDeviceListWidget.dart';
import 'package:app_test/View/Widgets/BleStatusWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

class BleScreen extends StatelessWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          if (status == BleStatus.ready) {
            return const DeviceListScreen();
          } else {
            return BleStatusWidget(status: status ?? BleStatus.unknown);
          }
        },
      );
}
