import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/pages/reset_page.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/custom_textfield.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:provider/provider.dart';

class forgetPage extends StatefulWidget {
  @override
  _forgetPageState createState() => _forgetPageState();
}

class _forgetPageState extends State<forgetPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 24, right: 42, left: 42),
            child: MyTextFormField(
              textEditingController: textEditingController,
              labelText: "Mobile Number",
              hintText: 'Mobile Number',
              isEmail: false,
            ),
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
                  GetData(textEditingController.text);
                  // Nav.routeReplacement(context, RegisterPage());
                },
                child: Text(
                  _isLoading ? "Proccessing" : "Reset",
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
    );
  }

  bool _isLoading = false;

  GetData(phone) {
    setState(() {
      _isLoading = true;
    });
    fetchData.resetPass(phone).then((value) {
      var data = jsonDecode(value);
      if (data['status_code'] == 200) {
        setState(() {
          _isLoading = false;
        });
        Route route = MaterialPageRoute(builder: (context) => ResetPage(phone));

        Navigator.push(context, route);
      } else {
        setState(() {
          _isLoading = false;
        });
        Flushbar(
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          title: "Status",
          message: "Something went wrong",
        )..show(context);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  FetchData fetchData = FetchData();
}
