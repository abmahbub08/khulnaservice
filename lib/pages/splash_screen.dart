import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../main.dart';
import 'onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _getUser();
    });
  }

  void _getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    if (token != null) {
      Nav.routeReplacement(context, InitPage());
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OnboardingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: mainColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Container(
          height: 240,
          width: ScreenUtil.getWidth(context) / 2,
          child: Image.asset('assets/images/kslogo.png'),
        ),
      ),
    );
  }
}
