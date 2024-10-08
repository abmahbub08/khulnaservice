import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/login_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';

class AuthHeader extends StatelessWidget {
  final String headerTitle;
  final String headerBigTitle;
  final bool isLoginHeader;
  bool iSFromLogin;

  AuthHeader(
      {this.headerTitle,
      this.headerBigTitle,
      this.isLoginHeader,
      this.iSFromLogin});

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: themeColor.getColor().withOpacity(0.5),
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
          color: themeColor.getColor(),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      padding: EdgeInsets.all(16),
      height: ScreenUtil.getHeight(context) * 0.3,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              headerTitle,
              style: GoogleFonts.poppins(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          this.isLoginHeader
              ? Container()
              : Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      if (iSFromLogin) {
                        Nav.routeReplacement(context, LoginPage());
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    headerBigTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Account",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
