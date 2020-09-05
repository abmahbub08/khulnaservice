import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class OrderConfirm extends StatefulWidget {
  var orderID;
  var statusMsg;
  Color statusColor;

  OrderConfirm(this.orderID, this.statusMsg, this.statusColor);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  FetchData fetchData = FetchData();
  bool isLoading = false;
  var myData;

  @override
  void initState() {
    fetchData.IndividualOrder(widget.orderID.toString()).then((value) {
      var data = jsonDecode(value);
      print(data);
      myData = data;
      setState(() {
        isLoading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () {
          return Nav.routeReplacement(context, MyApp());
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(42.0), // here the desired height
            child: AppBar(
              backgroundColor: greyBackground,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Order Information",
                style:
                    GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 15),
              ),
              leading: InkWell(
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => MyApp()));

                  Navigator.pushReplacementNamed(context, '/initPage');
                },
                child: Icon(
                  Icons.chevron_left,
                  color: textColor,
                  size: 32,
                ),
              ),
            ),
          ),
          body: isLoading
              ? SingleChildScrollView(
                child: Column(
                    children: [
                      Center(
                          child: Container(
                        width: size.width * 0.85,
                        color: widget.statusColor,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.statusMsg,
                            style: TextStyle(fontSize: 18),
                          ),
                        )),
                      )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 35, top: 20, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID: ${myData['order']['id']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Payment Status: ${myData['order']['payment_state']}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Order Status: ${myData['order']['order_state']}"),
                            SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: myData['orderProducts'].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.withOpacity(.2),
                                                  blurRadius:
                                                      6.0, // soften the shadow
                                                  spreadRadius:
                                                      0.0, //extend the shadow
                                                  offset: Offset(
                                                    0.0,
                                                    // Move to right 10  horizontally
                                                    1.0, // Move to bottom 10 Vertically
                                                  ),
                                                )
                                              ]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    "$imageLink/ims/?src=/uploads/product/${myData['orderProducts'][index]['product']['id']}/front/cropped/${myData['orderProducts'][index]['product']['image']}&p=small",
                                                    height: size.height * 0.075,
                                                    width: size.width * 0.14,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                          width:
                                                              size.width * 0.58,
                                                          child: Text(
                                                              myData['orderProducts']
                                                                          [index]
                                                                      ['product']
                                                                  ['name'])),
                                                      Text(
                                                          "৳ ${double.parse(myData['orderProducts'][index]['product']['discounted_price']) != 0 ? myData['orderProducts'][index]['product']['discounted_price'] : myData['orderProducts'][index]['product']['price']}"),
                                                      Text(
                                                          "Quantity: ${myData['orderProducts'][index]['quantity']}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Additional Shipping cost: ${myData['orderProducts'][index]['product']['shipping']}"),
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
                                    "Sub Total : ${double.parse(Provider.of<placeOrderProvider>(context, listen: false).searchData.total.toString().substring(1, Provider.of<placeOrderProvider>(context, listen: false).searchData.total.length)) - (Provider.of<placeOrderProvider>(context, listen: false).searchData.shippingCondition == null ? 0.0 : double.parse(Provider.of<placeOrderProvider>(context, listen: false).searchData.shippingCondition.toString().substring(1, Provider.of<placeOrderProvider>(context, listen: false).searchData.shippingCondition.length)))}"),
                              ),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 35,)
                    ],
                  ),
              )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
