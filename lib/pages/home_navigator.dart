import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/pages/search_page.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/category_page.dart';
import 'package:khulnaservice/pages/favorite_products_page.dart';
import 'package:khulnaservice/pages/home_page.dart';
import 'package:khulnaservice/pages/my_profile_page.dart';
import 'package:khulnaservice/pages/shopping_cart_page.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _currentPage = 0;

  List<Widget> _pages = [
    HomePage(),
    CategoryPage(),
    ShoppingCartPage(),
    SearchPage(false),
    MyProfilePage()
  ];
  bool IsLoading = false;
  FetchData fetchData = FetchData();

  @override
  void initState() {
    fetchData.getHomePageData(context).then((value) {
      fetchData.getCategory(context).then((value) {
        fetchData.getCart(context).then((value) {
          setState(() {
            IsLoading = true;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      bottomNavigationBar: IsLoading
          ? Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ConvexAppBar(
                color: Color(0xFF5D6A78),
                backgroundColor: Colors.white,
                activeColor: themeColor.getColor(),
                elevation: 0.0,
                top: -28,
                onTap: (int val) {
                  if (val == _currentPage) return;
                  setState(() {
                    _currentPage = val;
                  });
                },
                curveSize: 0,
                initialActiveIndex: _currentPage,
                style: TabStyle.fixedCircle,
                items: <TabItem>[
                  TabItem(icon: Feather.home, title: ''),
                  TabItem(icon: Feather.list, title: ''),
                  TabItem(icon: bottomCenterItem(themeColor), title: ''),
                  TabItem(icon: Feather.search, title: ''),
                  TabItem(icon: Feather.user, title: ''),
                ],
              ),
            )
          : SizedBox(),
      body: IsLoading
          ? _pages[_currentPage]
          : Center(child: CircularProgressIndicator()),
    );
  }

  bottomCenterItem(ThemeNotifier themeColor) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ], color: Colors.white, borderRadius: BorderRadius.circular(32)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Badge(
                    badgeColor: themeColor.getColor(),
                    padding: EdgeInsets.all(4),
                    badgeContent: Text(
                      '${context.watch<CartProvider>().cartList.cart.length}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: SvgPicture.asset(
                        "assets/icons/ic_shopping_cart_bottom.svg"),
                  ),
                  alignment: Alignment.center,
                ),
                Text(
                  "৳${context.watch<CartProvider>().addAmount()}",
                  style: TextStyle(color: themeColor.getColor()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
