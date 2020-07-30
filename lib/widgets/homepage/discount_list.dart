import 'package:flutter/material.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/homepage/discount_item.dart';
import 'package:khulnaservice/widgets/homepage/product_list_titlebar.dart';

class DiscountList extends StatelessWidget {
  DiscountList(
      {Key key,
      @required this.themeColor,
      this.productListTitleBar,
      this.title,
      this.myData,
      this.image})
      : super(key: key);

  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;
  final String title;
  List<Product> myData;
  final image;

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
              child: new ListView.builder(
                itemCount: myData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DiscountItem(
                    product: myData[index],
                    themeColor: themeColor,
                  );
                },
//                children: <Widget>[
//                  DiscountItem(
//                      title: title,
//                      themeColor: themeColor,
//                      imageUrl: "prodcut1.png"),
//                  DiscountItem(
//                      title: title,
//                      themeColor: themeColor, imageUrl: "prodcut2.png"),
//                  DiscountItem(
//                      title: title,
//                      themeColor: themeColor, imageUrl: "prodcut3.png"),
//                ],
              )),
        ],
      ),
    );
  }
}
