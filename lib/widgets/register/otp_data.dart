import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/pages/login_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/auth_header.dart';
import 'package:khulnaservice/widgets/register/register_form.dart';
import 'package:khulnaservice/widgets/register/social_auth_register.dart';
import 'package:provider/provider.dart';

import 'otp_form.dart';

class OtpData extends StatefulWidget {
  var number;

  OtpData(this.number);

  @override
  _OtpDataState createState() => _OtpDataState();
}

class _OtpDataState extends State<OtpData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return SafeArea(
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
                  isLoginHeader: true,
                ),
                OtpDataForm(widget.number),
                SizedBox(
                  height: 450,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
