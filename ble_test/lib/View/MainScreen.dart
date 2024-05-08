import 'package:app_test/View/Widgets/PermissionStatusText.dart';
import 'package:app_test/View/Widgets/PermissonButton.dart';
import 'package:app_test/ViewModel/PermissionStatusProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PermissionStatusProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!),
        home: Scaffold(
          appBar: AppBar(
            title: Text("BLE TEST"),
            backgroundColor: Colors.blueGrey,
            shadowColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              children: [
                PermissoinButton(),
                PermissionStatusText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
