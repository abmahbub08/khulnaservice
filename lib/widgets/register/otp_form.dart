import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/custom_textfield.dart';
import 'package:khulnaservice/widgets/commons/shadow_button.dart';
import 'package:khulnaservice/widgets/register/registration_phone.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class OtpDataForm extends StatefulWidget {
  var number;

  OtpDataForm(this.number);

  @override
  _OtpDataFormState createState() => _OtpDataFormState();
}

class _OtpDataFormState extends State<OtpDataForm> {
  TextEditingController fName = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool passwordVisible = false;

  bool _isLoading = false;

  String name, email, password;

  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      numberController.text = widget.number;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      padding: EdgeInsets.only(top: 24, right: 36, left: 48),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: MyTextFormField(
                isEmail: true,
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
              isFalse: false,
              textEditingController: numberController,
              labelText: "Mobile Number",
              hintText: 'Mobile Number',
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
              isEmail: true,
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
                    _form.currentState.save();
                    _form.currentState.validate();
                    getReg(context, name, email, password);
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

  getReg(cont, String name, email, password) async {
    _form.currentState.validate();
    if (_form.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      fetchData
          .getRegPhone(context, name, numberController.text, password)
          .then((value) async {
        fetchData.profileData(context).then((value) {
          setState(() {
            _isLoading = false;
          });

          Navigator.pushReplacementNamed(context, '/myApp');
        }).catchError((onError) {
          print("Here $onError");
          setState(() {
            _isLoading = false;
          });

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong", textAlign: TextAlign.center),
          ));
        });
      }).catchError((onError) {
        print("reg $onError");
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
