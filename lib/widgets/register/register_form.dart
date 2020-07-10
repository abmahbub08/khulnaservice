import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

import '../../main.dart';
import '../commons/custom_textfield.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController fName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool _isLoading = false;

  String name, email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      padding: EdgeInsets.only(top: 24, right: 36, left: 48),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: MyTextFormField(
                labelText: "Full Name",
                hintText: 'Full Name',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your last name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  name = value;
                },
              ),
            ),
            MyTextFormField(
              labelText: "Email",
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (String value) {
                email = value;
              },
            ),
            MyTextFormField(
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
                } else if (value != password) {
                  return "password don't match";
                }

                return null;
              },
              onSaved: (String value) {
                password = value;
              },
            ),
            MyTextFormField(
              labelText: "Re-Password",
              hintText: 'Re-Password',
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
                } else if (value != password) {
                  return "password don't match";
                }

                return null;
              },
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
                    _formKey.currentState.save();
                    _formKey.currentState.validate();
                    getReg(name, email, password);
                  },
                  child: Text(
                    _isLoading ? 'Creating.....' : 'Register',
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

  getReg(String name, String email, String password) async {
    _formKey.currentState.validate();
    SharedPreferences Sp = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      fetchData.geReg(name, email, password).then((value) async {
        var data = jsonDecode(value);

        setState(() {
          _isLoading = false;
        });
        Nav.routeReplacement(context, InitPage());
      }).catchError((onError) {
        setState(() {
          _isLoading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong", textAlign: TextAlign.center),
        ));
      });
    }
  }
}
