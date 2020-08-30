import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/register_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/auth_header.dart';
import 'package:khulnaservice/widgets/login/login_form.dart';
import 'package:khulnaservice/widgets/login/social_auth_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      var token = sp.getString('token');
      if(token != null) {
        Nav.routeReplacement(context, InitPage());

        print(token);
      }
      else {
        print('nothing');
      }
  } 




  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AuthHeader(
                  headerTitle: "Login",
                  headerBigTitle: "New",
                  isLoginHeader: true),
              SizedBox(
                height: 36,
              ),
              LoginForm(),
              SizedBox(
                height: 8,
              ),
              routeRegisterWidget(themeColor, context),
              SocialLoginButtons(themeColor: themeColor)
            ],
          ),
        ),
      ),
    );
  }

  routeRegisterWidget(ThemeNotifier themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 42, left: 42, bottom: 12),
      child: Row(
        children: <Widget>[
          Text(
            "Do you have an account?",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
          FlatButton(
            child: Text(
              "Register",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, RegisterPage());
            },
          )
        ],
      ),
    );
  }
}
