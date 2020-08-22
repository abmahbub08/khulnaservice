import 'package:flutter/material.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/pumpkin.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:provider/provider.dart';

class customWidget {
  myDiaglog(ctx) {
    return showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (context) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 120),
            child: Container(
              color: Colors.transparent,
              height: 100,
              width: 50,
              child: Center(
                child: PumpingHeart(
                  image: Image.asset(
                    "assets/images/produload.jpg",
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            )));
  }

  myShowDialog(ctx, value) {
    final themeColor = Provider.of<ThemeNotifier>(ctx,listen: false);
    return showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (context) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 120),
            child: Container(
                color: Colors.transparent,
                height: 180,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(value),
                    Divider(),
                    RaisedButton(
                      color: themeColor.getColor(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ))));
  }
}
