import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
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
import 'forgetNumber.dart';

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
    if (token != null) {
      Nav.routeReplacement(context, InitPage());

      print(token);
    } else {
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
                  headerBigTitle: "Login",
                  isLoginHeader: true),
              SizedBox(
                height: 36,
              ),
              LoginForm(),
              SizedBox(
                height: 8,
              ),
              Column(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => ForgetNumber());
                        Navigator.push(context, route);
                      },
                      child: Text(
                        "Reset your password",
                        style: GoogleFonts.poppins(
                          color: themeColor.getColor(),
                        ),
                      )),
                  Text(
                    "Don't you have an account?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 42,
                    padding: EdgeInsets.only(right: 42, left: 42),
                    width: ScreenUtil.getWidth(context),
                    margin: EdgeInsets.only(top: 15, bottom: 12),
                    child: ShadowButton(
                      borderRadius: 12,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        color: themeColor.getColor(),
                        onPressed: () {
                          Nav.routeReplacement(context, RegisterPage());
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SocialLoginButtons(themeColor: themeColor)
            ],
          ),
        ),
        // bottomNavigationBar: routeRegisterWidget(themeColor, context),
      ),
    );
  }

// routeRegisterWidget(ThemeNotifier themeColor, BuildContext context) {
//   return Container(
//     padding: EdgeInsets.only(right: 36, left: 35, bottom: 12),
//     child: Column(
//       children: <Widget>[
//         Text(
//           "Don't you have an account?",
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             color: Colors.black,
//             fontWeight: FontWeight.w200,
//           ),
//         ),
//         SizedBox(
//           width: 15,
//         ),
//         RaisedButton(
//           color: themeColor.getColor(),
//           child: Text(
//             "Register",
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           onPressed: () {
//             Nav.routeReplacement(context, RegisterPage());
//           },
//         )
//       ],
//     ),
//   );
// }
}
