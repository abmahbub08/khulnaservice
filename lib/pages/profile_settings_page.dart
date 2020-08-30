import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/provider/profile_data_provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/address_page.dart';
import 'package:khulnaservice/pages/change_password_page.dart';
import 'package:khulnaservice/pages/edit_user_info_page.dart';
import 'package:khulnaservice/pages/notification_settings_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';

import 'address.dart';
import 'edit_image.dart';
import 'new_adress_page.dart';

class MyProfileSettings extends StatefulWidget {
  @override
  _MyProfileSettingsState createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
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
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Settings",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Color(0xFF5D6A78)),
                        ),
                        Container(
                            width: 28,
                            child: Divider(
                              color: themeColor.getColor(),
                              height: 3,
                              thickness: 2,
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(
                        context,
                        AddressAll(
                            Provider.of<ProfileDataProvider>(context,
                                    listen: false)
                                .profileData
                                .primaryAddress,
                            "primary",0));
                  },
                  leading: Image.asset(
                    "assets/icons/ic_location.png",
                    width: 22,
                  ),
                  title: Text("Edit primary address ",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(
                        context,
                        AddressAll(
                            Provider.of<ProfileDataProvider>(context,
                                    listen: false)
                                .profileData
                                .shippingAddress,
                            "shipping",1));
                  },
                  leading: Image.asset(
                    "assets/icons/ic_location.png",
                    width: 22,
                  ),
                  title: Text("Edit shipping address ",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(
                        context,
                        AddressAll(
                            Provider.of<ProfileDataProvider>(context,
                                    listen: false)
                                .profileData
                                .billingAddress,
                            "billing",2));
                  },
                  leading: Image.asset(
                    "assets/icons/ic_location.png",
                    width: 22,
                  ),
                  title: Text("Edit billing address ",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  onTap: () {
                    Nav.route(context, ChangePasswordPage());
                  },
                  leading: Image.asset(
                    "assets/icons/ic_lock.png",
                    width: 22,
                  ),
                  title: Text("Edit Name",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Color(0xFF5D6A78))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
