import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/pages/login_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
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

  FetchData fetchData = FetchData();
  var onBoard = false;
  customWidget CustomWidget = customWidget();

  void _getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');


    if (token != null) {
      fetchData.profileData(context).then((value) {
        Nav.routeReplacement(context, InitPage());
      }).catchError((onError) {
        print(sp.get("email"));
        CustomWidget.myShowDialog(context, "Something went wrong");
      });
    } else {
      Nav.routeReplacement(context, LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: Colors.white,
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
