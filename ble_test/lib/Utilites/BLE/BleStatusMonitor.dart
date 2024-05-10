import 'package:app_test/Utilites/BLE/BleReactiveState.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleStatusMonitor implements BleReactiveState<BleStatus?> {
  const BleStatusMonitor(this._ble);

  final FlutterReactiveBle _ble;

  @override
  Stream<BleStatus?> get state => _ble.statusStream;
}
