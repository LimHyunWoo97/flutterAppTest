import 'package:app_test/Model/BLE_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

FlutterBluePlus flutterBlue = FlutterBluePlus();

class BluetoothDiscovery {
  // static을 통해 함수를 클래스에 귀속
  static Stream<List<BleModel>> getDevices() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    return FlutterBluePlus.scanResults.map((results) {
      List<BleModel> devices = [];
      for (var result in results) {
        if (result.device.name == 'LED BLE MESH SERVER') {
          final device = BleModel.fromScan(result);
          devices.add(device);
        }
      }
      return devices;
    });
  }
}
