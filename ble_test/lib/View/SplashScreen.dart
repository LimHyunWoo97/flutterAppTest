import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool enrollSkip = false;
  bool enrollEnable = false;
  bool adminEnable = false;
  bool guideEnable = false;
  String projectdata = '';
  //late AndroidNotificationChannel channel;
  //late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAppFutureBuilder(),
      builder: ((context, snapshot) {
        if (snapshot.hasData == false) {
          //앱 초기화하는 도중
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child!),
              home: AnimatedSplashScreen(
                splash: Image.asset('assets/images/HYUNWOO_logo2.png'),
                nextScreen: const MainScreen(),
                splashTransition: SplashTransition.slideTransition,
              ));
        } else if (snapshot.hasError) {
          //실패인데 여기 들어올 일 없음
          // ignore: avoid_unnecessary_containers
          return Container(
            child: const Center(
              child: Text('에러'),
            ),
          );
        } else {
          return const MainScreen();
        }
      }),
    );
  }

  Future<bool> initAppFutureBuilder() async {
    try {
      await Future.delayed(const Duration(milliseconds: 5000));
      return true;
    } catch (e, stackTrace) {
      print('initAppFutureBuilder에서 오류 발생: $e');
      print('스택 트레이스: $stackTrace');
      return false;
    }
  }
}

Future<bool> fetchData() async {
  bool data = false;
  await Future.delayed(const Duration(milliseconds: 10), () {
    data = true;
  });
  return data;
}
