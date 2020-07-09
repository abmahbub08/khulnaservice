import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/login_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/auth_header.dart';
import 'package:khulnaservice/widgets/register/register_form.dart';
import 'package:khulnaservice/widgets/register/social_auth_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: SafeArea(
        child: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            Nav.routeReplacement(context, LoginPage());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AuthHeader(
                    headerTitle: "Register",
                    headerBigTitle: "New",
                    isLoginHeader: false,
                  ),
                  RegisterForm(),
                  routeLoginWidget(themeColor, context),
                  SocialRegisterButtons(themeColor: themeColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget routeLoginWidget(ThemeNotifier themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 36, left: 48, bottom: 12),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Do you have an account?",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          FlatButton(
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, LoginPage());
            },
          )
        ],
      ),
    );
  }
}
