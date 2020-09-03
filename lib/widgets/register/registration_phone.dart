import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/auth_header.dart';
import 'package:khulnaservice/widgets/commons/custom_textfield.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';

import 'otp_page.dart';

class RegisterPhone extends StatefulWidget {
  @override
  _RegisterPhoneState createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  TextEditingController fName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool _isLoading = false;
  TextEditingController NumberController = TextEditingController();
  TextEditingController ReferralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 24, right: 36, left: 48),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Verify your phone number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You will receive a ontime PIN as an SMS",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 15),
                MyTextFormField(
                  howMany: 11,
                  textEditingController: ReferralController,
                  labelText: "Referral Code",
                  hintText: 'Referral Code',
                ),
                MyTextFormField(
                  howMany: 11,
                  textEditingController: NumberController,
                  labelText: "Mobile Number",
                  hintText: 'Mobile Number',
                ),
                Container(
                  height: 48,
                  width: ScreenUtil.getWidth(context),
                  margin: EdgeInsets.only(top: 12, bottom: 0),
                  child: ShadowButton(
                    borderRadius: 12,
                    height: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: themeColor.getColor(),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        if (NumberController.text.length == 11) {
                          fetchData
                              .sendOTP(ReferralController.text,
                                  NumberController.text)
                              .then((value) {
                            var data = jsonDecode(value);
                            setState(() {
                              _isLoading = false;
                            });
                            if (data['status_code'] == 200) {
                              setState(() {
                                _isLoading = false;
                              });
                              Nav.route(
                                  context,
                                  OtpPage(ReferralController.text,
                                      NumberController.text));
                            } else if (data['status_code'] == 8888) {
                              setState(() {
                                _isLoading = false;
                              });
                              CustomWidget.myShowDialog(context,
                                  "You requested too many times. Please contact support");
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              CustomWidget.myShowDialog(
                                  context, "Invalid Number");
                            }

//
                          }).catchError((onError) {
                            setState(() {
                              _isLoading = false;
                            });
                            CustomWidget.myShowDialog(
                                context, "Invalid Number");
                          });
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          CustomWidget.myShowDialog(context, "Invalid Number");
                        }
                      },
                      child: Text(
                        _isLoading ? "Processing" : 'Submit',
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
          ),
        ),
      ),
    );
  }

  customWidget CustomWidget = customWidget();

  FetchData fetchData = FetchData();
}
