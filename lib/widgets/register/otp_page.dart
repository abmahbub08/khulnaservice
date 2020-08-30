import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/custom_textfield.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';

import 'otp_data.dart';

class OtpPage extends StatefulWidget {
  var number;

  OtpPage(this.number);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    try {
      if (_timer.isActive) {
        _timer.cancel();
      }
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 24, right: 36, left: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: size.height * 0.27,
                    width: size.width * 0.8,
                  ),
                ),
                Text(
                  "Verify your number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 15),
                Text("A verification code has been sent"),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("to "),
                    Text(
                      widget.number,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
//            Container(
//              height: size.height * 0.07,
//              width: size.width * 0.9,
//              decoration: BoxDecoration(
//                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
//              child: Center(
//                  child: SizedBox(
//                width: size.width * 0.250,
//                child: TextFormField(
//
//
//                  inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                  decoration: InputDecoration(
//                     filled: true,
//                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
//                      hintText: "___  ___  ___  ___  ___",
//
//                      border: InputBorder.none),
//                ),
//              )),
//            )
                MyTextFormField(
                  textEditingController: otpController,
                  isEmail: true,
                  labelText: "OTP",
                  hintText: 'OTP',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 48,
                  width: ScreenUtil.getWidth(context),
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
                          isLoading = true;
                        });
                        fetchData
                            .verifyOTP(widget.number, otpController.text)
                            .then((value) {
                          var data = jsonDecode(value);
                          setState(() {
                            isLoading = false;
                          });
                          if (data['msg'] == "Success") {
                            Nav.routeReplacement(
                                context, OtpData(widget.number));
                          } else {
                            CustomWidget.myShowDialog(context, "Invalid OTP");
                          }
                        }).catchError((onError) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Text(
                        isLoading ? "Processing" : 'Submit',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                isTry
                    ? Column(
                        children: [
                          Text(
                            "Did'nt get the code?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              fetchData.sendOTP(widget.number);
                              setState(() {
                                isTry = false;
                              });
                              startTimer();
                            },
                            child: Text(
                              "Send Again",
                              style: TextStyle(color: themeColor.getColor()),
                            ),
                          ),
                        ],
                      )
                    : Text("Send OTP again ($_start)")
              ],
            ),
          ),
        ),
      ),
    );
  }

  var currentSignOtp;

  FetchData fetchData = FetchData();
  Timer _timer;
  int _start = 59;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            isTry = true;
            timer.cancel();
            _start = 59;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  customWidget CustomWidget = customWidget();
  bool isTry = false;
  bool isLoading = false;

  TextEditingController otpController = TextEditingController();
}
