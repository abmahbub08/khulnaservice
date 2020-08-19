import 'package:flutter/material.dart';
import 'package:khulnaservice/widgets/pumpkin.dart';

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
}
