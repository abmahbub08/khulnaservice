import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/main.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:validators/validators.dart' as validator;

import '../commons/custom_textfield.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool _isLoading = false;
  var email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyTextFormField(
              labelText: "Email OR Mobile Number",
              hintText: 'Email OR Mobile Number',
              isEmail: true,

//              validator: (String value) {
//                if (!validator.isEmail(value)) {
//                  return 'Please enter a valid email';
//                }
//                return null;
//              },
              onSaved: (String value) {
                email = value;
              },
            ),
            MyTextFormField(
              isEmail: true,
              labelText: "Password",
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: themeColor.getColor(),
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              isPassword: passwordVisible,
              validator: (String value) {
                if (value.length < 7) {
                  return 'Password should be minimum 7 characters';
                }

                return null;
              },
              onSaved: (String value) {
                password = value;
              },
            ),
            Container(
              height: 42,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
              child: ShadowButton(
                borderRadius: 12,
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                  ),
                  color: themeColor.getColor(),
                  onPressed: () {
                    _formKey.currentState.save();
                    getLogin(email, password);
                  },
                  child: Text(
                    _isLoading ? 'Processing...' : 'Sign In',
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
    );
  }

  FetchData fetchData = FetchData();

  getLogin(String email, String password) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        int.parse(email);

        fetchData.getLog(context, "phone", "+88$email", password).then((value) {
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
      } catch (e) {
        fetchData.getLog(context, "email", email, password).then((value) {
          var body = jsonDecode(value);
          if (body['message'] == 'success') {
            fetchData.profileData(context).then((value) {
              setState(() {
                _isLoading = false;
              });
              Nav.routeReplacement(context, InitPage());
            }).catchError((onError) {
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
              message: body['message'],
            )..show(context);

          }
        }).catchError((e) {
          setState(() {
            _isLoading = false;
          });

          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            title: "Status",
            message: e,
          )..show(context);
        });
      }
    }
  }
}
