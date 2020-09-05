import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/utils/drop_down_menu/find_dropdown.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/order_page.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../config.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<ShoppingCartPage>
    with SingleTickerProviderStateMixin {
  Box myCartBox;
  int total = 0;
  FetchData fetchData = FetchData();
  customWidget CustomWidget = customWidget();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 300), () {
      Provider.of<CartProvider>(context, listen: false).myCartItemQuantityAdd();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    var myCart =
        Provider.of<CartProvider>(context, listen: false).cartList.cart;
    total = 0;
    myCart.forEach((element) {
      total = total + element.price * int.parse(element.quantity.toString());
    });
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      bottomSheet: shoppingCartBottomSummary(themeColor),
      backgroundColor: whiteColor,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//                SearchBox(),
              SizedBox(
                height: 26,
              ),
              shoppingCartInfo(),
              SizedBox(
                height: 12,
              ),
              ListView.builder(
                itemCount: myCart.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: 8, left: 24, bottom: 8, right: 24),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 5.0,
                                      spreadRadius: 1,
                                      offset: Offset(0.0, 1)),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/produload.jpg",
                                        image:
                                            "$imageLink/ims/?src=/uploads/product/${myCart[index].id}/front/cropped/${myCart[index].attributes.image}&p=small",
                                        fit: BoxFit.cover,
                                        width:
                                            ScreenUtil.getWidth(context) * 0.30,
                                      )
//                                      Image.network(
//                                        "https://khulnaservice.com/ims/?src=/uploads/product/${myCart[index].id}/front/cropped/${myCart[index].attributes.image}&p=small",
//                                        fit: BoxFit.cover,
//                                        width:
//                                            ScreenUtil.getWidth(context) * 0.30,
//                                      ),
                                      ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 160,
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  width: ScreenUtil.getWidth(context) / 2,
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      AutoSizeText(
                                        myCart[index].name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Color(0xFF5D6A78),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        maxLines: 2,
                                        minFontSize: 11,
                                      ),
                                      Row(
                                        children: <Widget>[
//                                                Text(
//                                                  "${myCart[index].attributes.price}",
//                                                  style: GoogleFonts.poppins(
//                                                      decoration:
//                                                      TextDecoration
//                                                          .lineThrough,
//                                                      fontSize: 14,
//                                                      fontWeight:
//                                                      FontWeight.w300),
//                                                ),
//                                                SizedBox(
//                                                  width: 4,
//                                                ),
                                          Text(
                                            "${myCart[index].price}",
                                            style: GoogleFonts.poppins(
                                                color: themeColor.getColor(),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 12,
                            child: IconButton(
                              icon: Icon(
                                Feather.trash,
                                size: 18,
                                color: Color(0xFF5D6A78),
                              ),
                              onPressed: () {
//                                      myCartBox
//                                          .delete(int.parse(value['id']))
//                                          .then((value) {
//                                        Provider.of<CartProvider>(context,
//                                                listen: false)
//                                            .addCartLength("value");
//                                      });
//                                      getTotal();
//

                                CustomWidget.myDiaglog(context);
                                fetchData
                                    .deleteCart(context, myCart[index].id)
                                    .then((value) {
                                  fetchData.getCart(context).then((value) {
                                    total = 0;
                                    Navigator.of(context, rootNavigator: true).pop();
                                    setState(() {});
                                  });
                                });
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 24,
                            right: 32,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Future.delayed(Duration(milliseconds: 50),
                                        () {
                                      CustomWidget.myDiaglog(context);
                                      context
                                          .read<CartProvider>()
                                          .removeQuantity(myCart[index].id);
                                      fetchData
                                          .updateCart(
                                              context,
                                              myCart[index].id,
                                              Provider.of<CartProvider>(context,
                                                              listen: false)
                                                          .getQuantity(
                                                              myCart[index]
                                                                  .id) ==
                                                      null
                                                  ? "1"
                                                  : Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .getQuantity(
                                                          myCart[index].id)
                                                      .toString())
                                          .then((value) {
                                        fetchData
                                            .getCart(context)
                                            .then((value) {
                                          Navigator.pop(context);
                                          setState(() {});
                                        });
                                      });
                                    });
                                  },
                                  child: Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Icon(
                                      Icons.remove,
                                      size: 15,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 22,
                                  width: 40,
                                  color: themeColor.getColor().withOpacity(0.2),
                                  child: Center(
                                    child: Text(context
                                                .watch<CartProvider>()
                                                .getQuantity(
                                                    myCart[index].id) ==
                                            null
                                        ? "1"
                                        : context
                                            .watch<CartProvider>()
                                            .getQuantity(myCart[index].id)
                                            .toString()),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    CustomWidget.myDiaglog(context);
                                    context
                                        .read<CartProvider>()
                                        .addQuantity(myCart[index].id);
                                    fetchData
                                        .updateCart(
                                            context,
                                            myCart[index].id,
                                            Provider.of<CartProvider>(context,
                                                            listen: false)
                                                        .getQuantity(
                                                            myCart[index].id) ==
                                                    null
                                                ? "1"
                                                : Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .getQuantity(
                                                        myCart[index].id)
                                                    .toString())
                                        .then((value) {
                                      fetchData.getCart(context).then((value) {
                                        Navigator.pop(context);
                                        setState(() {});
                                      });
                                    });
                                  },
                                  child: Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 15,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),

              SizedBox(
                height: 130,
              )
            ],
          )),
        ],
      ),
    ));
  }

  Widget shoppingCartInfo() {
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Row(
        children: <Widget>[
          Text(
            "My Shopping Cart",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF5D6A78)),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
              "${Provider.of<CartProvider>(context, listen: false).cartList.cart.length} products",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF5D6A78))),
        ],
      ),
    );
  }

  Widget shoppingCartBottomSummary(ThemeNotifier themeColor) {
    var size = MediaQuery.of(context).size;
    var data = Provider.of<CartProvider>(context, listen: false).cartList.cart;
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              //                   <--- left side
              color: themeColor.getColor(),
            ),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 9.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      height: size.height *0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: size.height *0.09,
            width: size.width *0.38,
            child: RaisedButton(
              color: themeColor.getColor(),
              child: Text(
                "Place Order",
                style: GoogleFonts.poppins(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (data.length == 0) {
                  CustomWidget.myShowDialog(context, "Your cart is empty");
                } else {
                  CustomWidget.myDiaglog(context);
                  fetchData.getPlaceOrderData(context).then((value) {
                    Navigator.of(context, rootNavigator: true).pop();
                    Nav.route(context, OrderPage());
                  }).catchError((e) {
                    print(e);
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomWidget.myShowDialog(context, "Something went wrong");
                  });
                }
              },
            ),
          ),
          Row(
            children: [
              Text(
                "Total : ",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor.getColor()),
              ),
              Text(
                "${total} Tk    ",
                style: GoogleFonts.poppins(
                    fontSize: 20, color: themeColor.getColor()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
