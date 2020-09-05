import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/config.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/models/orderListModel.dart';
import 'package:flutter/src/widgets/image.dart' as im;

class OrderItem extends StatelessWidget {
  final String imageUrl;
  Order order;

  OrderItem({Key key, this.imageUrl, this.order, ThemeNotifier themeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
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
      width: ScreenUtil.getWidth(context) / 1.25,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(

               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: AutoSizeText(
                      "  Order id : ${order.id}",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Color(0xFF5D6A78),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      minFontSize: 11,
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "  ৳ ${order.total}",
                      style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Row(
                  children: [
                    Text("Payment :"),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
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
                        children: <Widget>[
                          Text(
                            "  ${order.paymentState}",
                            style: GoogleFonts.poppins(
                                color: Color(0xFF5D6A78),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            FontAwesome5.dot_circle,
                            size: 12,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),


                Row(
                  children: [
                    Text("Order :"),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
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
                          children: <Widget>[
                            Text(
                              "  ${order.orderState}",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF5D6A78),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              FontAwesome5.dot_circle,
                              size: 12,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )

                ],
              ),

              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        right: 26),
                    child: Text("Delivery Charge ${order.shipping}"),
                  )),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: ExpandablePanel(
//                  hasIcon: true,
//                  iconColor: themeColor.getColor(),
//                  headerAlignment: ExpandablePanelHeaderAlignment.center,
//                  iconPlacement: ExpandablePanelIconPlacement.right,
                  header: Text(
                    "View product specifications",
                    style: GoogleFonts.poppins(
                        color: Color(0xFF5D6A78), fontSize: 12),
                  ),
                  expanded: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.cart.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    im.Image.network(
                                      "$imageLink/ims/?src=/uploads/product/${order.cart[index].id}/front/cropped/${order.cart[index].attributes.image}&p=small",
                                      height: 70,
                                    ),
                                    SizedBox(width: 10,),
                                    SizedBox(
                                      width: size.width *0.55,
                                      child: Column(
                                        children: [
                                          Text(order.cart[index].name),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  "Price: ${order.cart[index].price}"),
                                              Text(
                                                  "Quantity: ${order.cart[index].quantity}"),
                                            ],
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                Divider()
                              ],
                            );
                          })),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
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
                Text("Rate",
                    style: GoogleFonts.poppins(color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 16,
                ),
                RatingBar(
                  initialRating: 3,
                  itemSize: 22.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Container(
                    height: 12,
                    child: SvgPicture.asset(
                      "assets/icons/ic_star.svg",
                      color: Colors.red,
                      width: 9,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text("You gave 4 points",
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Color(0xFF5D6A78))),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 260,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: themeColor.getColor(),
                    child: Text(
                      "Rate",
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
