import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/profile_data_provider.dart';
import 'package:khulnaservice/provider/user_provider.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/textfield_bottomline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    var user = Provider.of<ProfileDataProvider>(context, listen: false)
        .profileData
        .user;
    setState(() {
      nameController.text = user.name;
    });
  }

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
          onTap: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            CustomWidget.myDiaglog(context);
            fetchData.nameUpdate(nameController.text).then((value) {
              fetchData.profileData(context).then((value) {
                Navigator.of(context, rootNavigator: true).pop();
                CustomWidget.myShowDialog(context, "Profile Name Updated");
              }).catchError((onError) {
                CustomWidget.myShowDialog(context, "Something went wrong");
              });
            }).catchError((e) {
              Navigator.of(context, rootNavigator: true).pop();
              CustomWidget.myShowDialog(context, "Something went wrong");
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: textColor,
                        size: 32,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text(
                          "Change Name",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: textColor),
                        ),
                        Container(
                            width: 28,
                            child: Divider(
                              color: themeColor.getColor(),
                              height: 3,
                              thickness: 2,
                            )),
                      ],
                    )
                  ],
                ),
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
