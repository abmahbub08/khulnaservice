import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/orders_detail/order_item.dart';

class OrdersDetailPage extends StatefulWidget {
  @override
  _OrdersDetailPageState createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  FetchData fetchData = FetchData();
  bool isLoading = false;

  @override
  void initState() {
    fetchData.OrderList(context).then((value) {
      setState(() {
        isLoading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    var dataList = Provider.of<placeOrderProvider>(context).orderList;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(42.0), // here the desired height
            child: AppBar(
              backgroundColor: greyBackground,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Order Details",
                style:
                    GoogleFonts.poppins(color: Color(0xFF5D6A78), fontSize: 15),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.chevron_left,
                  color: textColor,
                  size: 32,
                ),
              ),
            ),
          ),
          backgroundColor: greyBackground,
          key: _drawerKey, // assign key to Scaffold

          body: isLoading
              ? Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
//                  Container(
//                    width: ScreenUtil.getWidth(context),
//                    margin: EdgeInsets.only(left: 16, right: 16, top: 8),
//                    padding: EdgeInsets.only(left: 8, right: 8),
//                    decoration: BoxDecoration(
//                      boxShadow: [
//                        BoxShadow(
//                            color: Colors.grey[200],
//                            blurRadius: 8.0,
//                            spreadRadius: 1,
//                            offset: Offset(0.0, 3))
//                      ],
//                      color: Theme.of(context).bottomAppBarColor,
//                      borderRadius: BorderRadius.circular(12),
//                    ),
//                    child: ExpandablePanel(
//                      header: Text(
//                        "Order Details",
//                        style: GoogleFonts.poppins(
//                            color: Color(0xFF5D6A78), fontSize: 12),
//                      ),
//                      expanded: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Column(
//                          children: <Widget>[
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Container(
//                                  width: ScreenUtil.getWidth(context) / 4,
//                                  child: Text(
//                                    "The unveiled blessing of harmony is to meet with dogma  ",
//                                    softWrap: true,
//                                    style: GoogleFonts.poppins(
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w300,
//                                      color: Color(0xFF5D6A78),
//                                    ),
//                                  ),
//                                ),
//                                Text(
//                                  "1",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                ),
//                                Text(
//                                  "\$450",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                )
//                              ],
//                            ),
//                            Divider(),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Container(
//                                  width: ScreenUtil.getWidth(context) / 4,
//                                  child: Text(
//                                    "The unveiled blessing of harmony is to meet with dogma  ",
//                                    softWrap: true,
//                                    style: GoogleFonts.poppins(
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w300,
//                                      color: Color(0xFF5D6A78),
//                                    ),
//                                  ),
//                                ),
//                                Text(
//                                  "1",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                ),
//                                Text(
//                                  "\$450",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                )
//                              ],
//                            ),
//                            Divider(),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Container(
//                                  width: ScreenUtil.getWidth(context) / 4,
//                                  child: Text(
//                                    "The unveiled blessing of harmony is to meet with dogma  ",
//                                    softWrap: true,
//                                    style: GoogleFonts.poppins(
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w300,
//                                      color: Color(0xFF5D6A78),
//                                    ),
//                                  ),
//                                ),
//                                Text(
//                                  "1",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                ),
//                                Text(
//                                  "\$331",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                )
//                              ],
//                            ),
//                            Divider(),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Container(
//                                  width: ScreenUtil.getWidth(context) / 4,
//                                  child: Text(
//                                    "The unveiled blessing of harmony is to meet with dogma  ",
//                                    softWrap: true,
//                                    style: GoogleFonts.poppins(
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w300,
//                                      color: Color(0xFF5D6A78),
//                                    ),
//                                  ),
//                                ),
//                                Text(
//                                  "2",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                ),
//                                Text(
//                                  "\$450",
//                                  softWrap: true,
//                                  style: GoogleFonts.poppins(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    color: Color(0xFF5D6A78),
//                                  ),
//                                )
//                              ],
//                            ),
//                            Divider(),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
                          ListView.builder(
                            itemCount: dataList.orders.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return OrderItem(
                                  order: dataList.orders[index],
                                  themeColor: themeColor,
                                  imageUrl: "prodcut1.png");
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
