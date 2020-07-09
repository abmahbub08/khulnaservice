import 'package:flutter/material.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/homepage/discount_item.dart';
import 'package:khulnaservice/widgets/homepage/product_list_titlebar.dart';

class DiscountList extends StatelessWidget {
  const DiscountList({
    Key key,
    @required this.themeColor,
    this.productListTitleBar,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, top: 16, bottom: 8),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: 170.0,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  DiscountItem(
                      themeColor: themeColor, imageUrl: "prodcut1.png"),
                  DiscountItem(
                      themeColor: themeColor, imageUrl: "prodcut2.png"),
                  DiscountItem(
                      themeColor: themeColor, imageUrl: "prodcut3.png"),
                ],
              )),
        ],
      ),
    );
  }
}
