import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/custom_textfield.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:provider/provider.dart';

class ResetPage extends StatefulWidget {
  var phone;

  ResetPage(this.phone);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: 42, left: 42),
            child: MyTextFormField(
              textEditingController: newPass,
              labelText: "New Password",
              hintText: 'New Password',
              isEmail: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, right: 42, left: 42),
            child: MyTextFormField(
              textEditingController: confirmPass,
              labelText: "Confirm Password",
              hintText: 'Confirm Password',
              isEmail: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, right: 42, left: 42),
            child: MyTextFormField(
              textEditingController: OTPController,
              labelText: "OTP",
              hintText: 'OTP',
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
                  if (newPass.text != confirmPass.text) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      title: "Status",
                      message: "Password don't match",
                    )..show(context);
                  } else if (OTPController.text.isEmpty) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      title: "Status",
                      message: "Input your OTP",
                    )..show(context);
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    fetchData
                        .confirmReset(
                        widget.phone, newPass.text, OTPController.text)
                        .then((value) {
                      var data = jsonDecode(value);

                      if (data['msg'] == "Success") {
                        fetchData
                            .getLog(context, "phone", "+88${widget.phone}",
                            newPass.text)
                            .then((value) {
                          var body = jsonDecode(value);
                          if (body['message'] == 'success') {
                            fetchData.profileData(context).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushReplacementNamed(context, "/myApp");
                            }).catchError((onError) {
                              setState(() {
                                _isLoading = false;
                              });
                              Flushbar(
                                duration: Duration(seconds: 2),
                                title: "Status",
                                message: "Something went wrong",
                              )..show(context);
                            });
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            Flushbar(
                              duration: Duration(seconds: 2),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Status",
                              message: body['message'],
                            )..show(context);
                          }
                        }).catchError((e) {
                          print("login $e");
                          setState(() {
                            _isLoading = false;
                          });

                          Flushbar(
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            title: "Status",
                            message: "Something went wrong",
                          )..show(context);
                        });
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        Flushbar(
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          title: "Status",
                          message: "Something Went Wrong try again later!",
                        )..show(context);
                      }
                    });
                  }
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

  FetchData fetchData = FetchData();
}
