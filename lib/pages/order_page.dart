import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:khulnaservice/provider/profile_data_provider.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/main.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import '../webView.dart';
import 'new_adress_page.dart';
import 'order_confirm.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FetchData fetchData = FetchData();
  bool isCouponLoad = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    var user =
        Provider.of<ProfileDataProvider>(context, listen: false).profileData;

    setState(() {
      shipToController.text = user.user.name;
    });
  }

  TextEditingController couponController = TextEditingController();

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
    var myCart =
        Provider.of<CartProvider>(context, listen: false).cartList.cart;
    GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myCart.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.2),
                                      blurRadius: 6.0, // soften the shadow
                                      spreadRadius: 0.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        1.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    "$imageLink/ims/?src=/uploads/product/${myCart[index].id}/front/cropped/${myCart[index].attributes.image}&p=small",
                                    height: size.height * 0.075,
                                    width: size.width * 0.14,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: size.width * 0.58,
                                              child: Text(myCart[index].name)),
                                          Text("৳ ${myCart[index].price}"),
                                        ],
                                      ),
                                      Text(
                                          "Quantity: ${myCart[index].quantity}"),
                                      Text(
                                          "Additional Shipping cost: ${myCart[index].attributes.shipping}"),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      );
                    }),
                Divider(
                  thickness: 2,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                        "Normal delivery charge : ${Provider.of<placeOrderProvider>(context, listen: false).searchData.shippingCondition == null ? "৳ 00" : Provider.of<placeOrderProvider>(context, listen: false).searchData.shippingCondition}"),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "Total : ${Provider.of<placeOrderProvider>(context, listen: false).searchData.total}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 6.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            1.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.55,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: TextFormField(
                            controller: couponController,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: themeColor.getColor()),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: textColor),
                                ),
                                labelStyle: new TextStyle(
                                    color: const Color(0xFF424242)),
                                hintText: "Enter your coupon",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 12, color: textColor)),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            isCouponLoad = true;
                          });
                          fetchData.coupon(couponController.text).then((value) {
                            setState(() {
                              isCouponLoad = false;
                            });
                          }).catchError((onError) {
                            setState(() {
                              isCouponLoad = false;
                            });
                            CustomWidget.myShowDialog(
                                context, "Invalid Coupon");
                          });
                        },
                        color: themeColor.getColor(),
                        child: Text(
                          isCouponLoad ? "Processing" : "Add coupon",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Addresses",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      buildAddressItem(context, themeColor),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Select a payment method",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 6.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildPayMethodItem(
                                context, "Cash on Delivery", themeColor, 0),
                            buildPayMethodItem(
                                context, "Online Payment", themeColor, 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                  child: Text(
                    "Ship to",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 6.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: TextFormField(
                                controller: shipToController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themeColor.getColor()),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textColor),
                                    ),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                    hintText:
                                        "Enter name of the person who will receive order",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 12, color: textColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
                  child: Text(
                    "Order Instruction If Any",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xFF5D6A78)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8, right: 8, left: 8),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 6.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: notesController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: themeColor.getColor()),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: textColor),
                                    ),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                    hintText:
                                        "e,g call me when you arrive 0171**",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 12, color: textColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: GFButton(
            borderShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                6,
              ),
            ),
            child: Text("Confirm Order"),
            color: themeColor.getColor(),
            onPressed: () {
//                      Nav.route(context, CreditCartPage());
              var data = Provider.of<placeOrderProvider>(context,
                  listen: false)
                  .searchData;
              if (shipToController.text.isEmpty) {
                CustomWidget.myShowDialog(
                    context, "Enter the name who will receive");
              } else if (data.shippingAddress == null) {
                CustomWidget.myShowDialog(
                    context, "Add your shipping address");
              } else if (data.billingAddress == null) {
                CustomWidget.myShowDialog(
                    context, "Add your billing address");
              } else {
                CustomWidget.myDiaglog(context);
                fetchData
                    .checkOut(context, shipToController.text,
                    notesController.text, myMethod.toString())
                    .then((value) {
                  if (myMethod == 0) {
                    var data = jsonDecode(value);
                    Navigator.pop(context);
                    Route route = MaterialPageRoute(
                        builder: (context) => OrderConfirm(
                            data["order_id"],
                            "Your order has been placed. Khulna Service team will make a call very soon.",
                            Colors.green[100]));
                    Navigator.push(context, route);
                  } else {
                    Navigator.pop(context);
                    var data = jsonDecode(value);
                    Route route = MaterialPageRoute(
                        builder: (context) => webView(
                            "${paymentUrl}/pay?order_id=${data["order_id"]}"));
                    Navigator.push(context, route).then((value) {
                      print(value);

                      if (value
                          .toString()
                          .split("/")
                          .contains('success')) {
                        Route route = MaterialPageRoute(
                            builder: (context) => OrderConfirm(
                                data["order_id"],
                                "Your order has been placed. We would like to extend a very heartfelt thanks for placing your order. - KhulnaService Team",
                                Colors.green[100]));
                        Navigator.push(context, route);
                      } else if (value
                          .toString()
                          .split("/")
                          .contains('cancel')) {
                        Route route = MaterialPageRoute(
                            builder: (context) => OrderConfirm(
                                data["order_id"],
                                "Your order has been canceled",
                                Colors.red[100]));
                        Navigator.push(context, route);
                      } else if (value
                          .toString()
                          .split("/")
                          .contains('fail')) {
                        Route route = MaterialPageRoute(
                            builder: (context) => OrderConfirm(
                                data["order_id"],
                                "Your order has been failed",
                                Colors.orange[100]));
                        Navigator.push(context, route);
                      } else {
                        CustomWidget.myShowDialog(
                            context, "Something Went Wrong");
                      }
                    });
                  }
                }).catchError((onError) {
                  Navigator.pop(context);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: themeColor.getColor(),
                      content: Text('Something went wrong')));
                });
              }
            },
            type: GFButtonType.solid,
            fullWidthButton: true,
          ),
        ),
      ),
    );
  }

  buildPayMethodItem(BuildContext context, String title, themeColor, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: value,
              groupValue: myMethod,
              activeColor: themeColor.getColor(),
              focusColor: themeColor.getColor(),
              hoverColor: themeColor.getColor(),
              onChanged: (var value) {
                setState(() {
                  myMethod = value;
                });
              },
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF5D6A78)),
            ),
          ],
        ),
      ],
    );
  }

  buildAddressItem(BuildContext context, themeColor) {
    var data =
        Provider.of<placeOrderProvider>(context, listen: false).searchData;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 10, top: 24),
            child: Container(
              height: ScreenUtil.getHeight(context) * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GFButton(
                    focusColor: themeColor.getColor().withOpacity(0.5),
                    disabledColor: themeColor.getColor().withOpacity(0.5),
                    disabledTextColor: themeColor.getColor().withOpacity(0.5),
                    highlightColor: themeColor.getColor().withOpacity(0.5),
                    hoverColor: themeColor.getColor().withOpacity(0.5),
                    splashColor: themeColor.getColor().withOpacity(0.5),
                    color: themeColor.getColor(),
                    type: GFButtonType.outline,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => NewAddressPage(2, false),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 280),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: data.billingAddress == null
                        ? Row(
                          children: [
                            Text("Add billing"),
                            Text("*",style: TextStyle(color: Colors.redAccent),),
                          ],
                        )
                        : Row(
                          children: [
                            Text("Write billing"),
                            Text("*",style: TextStyle(color: Colors.redAccent),),
                          ],
                        ),
                  ),
                  GFButton(
                    focusColor: themeColor.getColor().withOpacity(0.5),
                    disabledColor: themeColor.getColor().withOpacity(0.5),
                    disabledTextColor: themeColor.getColor().withOpacity(0.5),
                    highlightColor: themeColor.getColor().withOpacity(0.5),
                    hoverColor: themeColor.getColor().withOpacity(0.5),
                    splashColor: themeColor.getColor().withOpacity(0.5),
                    color: themeColor.getColor(),
                    type: GFButtonType.outline,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => NewAddressPage(1, false),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 280),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: data.shippingAddress == null
                        ? Row(
                          children: [
                            Text("Add Shipping"),
                            Text("*",style: TextStyle(color: Colors.redAccent),),
                          ],
                        )
                        : Row(
                          children: [
                            Text("Write Shipping"),
                            Text("*",style: TextStyle(color: Colors.redAccent),),
                          ],
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

  buildItemRadio(BuildContext context, themeColor, value) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 24),
      width: ScreenUtil.getWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: value,
                groupValue: myMethod,
                activeColor: themeColor.getColor(),
                focusColor: themeColor.getColor(),
                hoverColor: themeColor.getColor(),
                onChanged: (var value) {},
              ),
              Expanded(
                  child: Text(
                "The lama respects truth which is not inward.truth which is not inwar",
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF5D6A78)),
              )),
            ],
          ),
        ],
      ),
    );
  }

  openAlertBox(context, themeColor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 180,
                    child: Text("Your order has been successfully completed.",
                        style: GoogleFonts.poppins(color: Color(0xFF5D6A78))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 220,
                    child: RaisedButton(
                      onPressed: () {
                        Nav.routeReplacement(context, InitPage());
                      },
                      color: themeColor.getColor(),
                      child: Text(
                        "OKEY",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          );
        });
  }

  var myMethod = 0;
  TextEditingController shipToController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  customWidget CustomWidget = customWidget();
  var myTotal;
}
