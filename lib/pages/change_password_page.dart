import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/textfield_bottomline.dart';
import 'package:validators/validators.dart' as validator;

import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final _formKey = GlobalKey<FormState>();
    bool passwordVisible = false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () {
            CustomWidget.myDiaglog(context);
            fetchData.nameUpdate(nameController.text).then((value) {
              Navigator.pop(context);
              CustomWidget.myShowDialog(context, "Profile Name Updated");
            });
          },
          child: isLoading
              ? Center()
              : Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  height: 42,
                  decoration: BoxDecoration(
                      color: themeColor.getColor(),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Change Name",
                  style: GoogleFonts.poppins(fontSize: 18, color: textColor),
                ),
                Container(
                    width: 28,
                    child: Divider(
                      color: themeColor.getColor(),
                      height: 3,
                      thickness: 2,
                    )),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        MyTextFormFieldLine(
                          controller: nameController,
                          labelText: "Name",
                          hintText: 'Name',
//                          isEmail: true,
//                          validator: (String value) {
////                            if (!validator.isEmail(value)) {
////                              return 'Please enter a valid email';
////                            }
//                            return null;
//                          },
                          onSaved: (String value) {
//                        model.email = value;
                          },
                        ),
//                        SizedBox(
//                          height: 16,
//                        ),
//                        MyTextFormFieldLine(
//                          labelText: "Password",
//                          hintText: 'Password',
//                          suffixIcon: IconButton(
//                            icon: Icon(
//                              // Based on passwordVisible state choose the icon
//                              passwordVisible
//                                  ? Icons.visibility
//                                  : Icons.visibility_off,
//                              color: themeColor.getColor(),
//                            ),
//                            onPressed: () {
//                              // Update the state i.e. toogle the state of passwordVisible variable
//                              setState(() {
//                                passwordVisible = !passwordVisible;
//                              });
//                            },
//                          ),
//                          isPassword: passwordVisible,
//                          validator: (String value) {
//                            if (value.length < 7) {
//                              return 'Password should be minimum 7 characters';
//                            }
//
//                            _formKey.currentState.save();
//
//                            return null;
//                          },
//                          onSaved: (String value) {
////                        model.password = value;
//                          },
//                        ),
//                        SizedBox(
//                          height: 16,
//                        ),
//                        MyTextFormFieldLine(
//                          labelText: "Confirm Password",
//                          hintText: 'Confirm Password',
//                          suffixIcon: IconButton(
//                            icon: Icon(
//                              // Based on passwordVisible state choose the icon
//                              passwordVisible
//                                  ? Icons.visibility
//                                  : Icons.visibility_off,
//                              color: themeColor.getColor(),
//                            ),
//                            onPressed: () {
//                              // Update the state i.e. toogle the state of passwordVisible variable
//                              setState(() {
//                                passwordVisible = !passwordVisible;
//                              });
//                            },
//                          ),
//                          isPassword: passwordVisible,
//                          validator: (String value) {
//                            if (value.length < 7) {
//                              return 'Password should be minimum 7 characters';
//                            }
//
//                            _formKey.currentState.save();
//
//                            return null;
//                          },
//                          onSaved: (String value) {
////                        model.password = value;
//                          },
//                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FetchData fetchData = FetchData();
  customWidget CustomWidget = customWidget();
  TextEditingController nameController = TextEditingController();
}
