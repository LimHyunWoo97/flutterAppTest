import 'package:app_test/Utilites/BLE/BleDeviceConnector.dart';
import 'package:app_test/Utilites/BLE/BleDeviceInteractor.dart';
import 'package:app_test/Utilites/BLE/BleLogger.dart';
import 'package:app_test/Utilites/BLE/BleScanner.dart';
import 'package:app_test/Utilites/BLE/BleStatusMonitor.dart';
import 'package:app_test/View/BleScreen.dart';
import 'package:app_test/View/Widgets/PermissionStatusText.dart';
import 'package:app_test/View/Widgets/PermissonButton.dart';
import 'package:app_test/ViewModel/PermissionStatusProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final _ble = FlutterReactiveBle();
    final _bleLogger = BleLogger(ble: _ble);
    final _scanner = BleScanner(ble: _ble, logMessage: _bleLogger.addToLog);
    final _monitor = BleStatusMonitor(_ble);
    final _connector = BleDeviceConnector(
      ble: _ble,
      logMessage: _bleLogger.addToLog,
    );
    final _serviceDiscoverer = BleDeviceInteractor(
      bleDiscoverServices: (deviceId) async {
        await _ble.discoverAllServices(deviceId);
        return _ble.getDiscoveredServices(deviceId);
      },
      logMessage: _bleLogger.addToLog,
      readRssi: _ble.readRssi,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PermissionStatusProvider()),
        Provider.value(value: _scanner),
        Provider.value(value: _monitor),
        Provider.value(value: _connector),
        Provider.value(value: _serviceDiscoverer),
        Provider.value(value: _bleLogger),
        StreamProvider<BleScannerState?>(
          create: (_) => _scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
        StreamProvider<BleStatus?>(
          create: (_) => _monitor.state,
          initialData: BleStatus.unknown,
        ),
        StreamProvider<ConnectionStateUpdate>(
          create: (_) => _connector.state,
          initialData: const ConnectionStateUpdate(
            deviceId: 'Unknown device',
            connectionState: DeviceConnectionState.disconnected,
            failure: null,
          ),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!),
          home: BleScreen()),
    );
  }
}
/* Scaffold(
          appBar: AppBar(
            title: Text("BLE TEST"),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              children: [
                // PermissoinButton(),
                // PermissionStatusText(),
                BleScreen(),
              ],
            ),
          ),
        ), */