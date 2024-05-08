import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleModel {
  BluetoothDevice? device;
  late String name;
  late DeviceIdentifier id;
  late bool isConnected;

  BleModel(
      {required this.device,
      required this.name,
      required this.id,
      required this.isConnected});
  factory BleModel.fromScan(ScanResult result) {
    // ignore: deprecated_member_use
    return BleModel(
        device: result.device,
        name: result.device.name,
        id: result.device.id,
        isConnected: false);
  }
}
