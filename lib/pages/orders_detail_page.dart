import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/main.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/orders_detail/order_item.dart';

class OrdersDetailPage extends StatefulWidget {
  bool isFromCart;

  OrdersDetailPage(this.isFromCart);

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
                  if (widget.isFromCart) {
                    Nav.routeReplacement(context, InitPage());
                  } else {
                    Navigator.pop(context);
                  }
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          dataList.orders.length == 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("No Order Available"),
                                  ),
                                )
                              : ListView.builder(
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
