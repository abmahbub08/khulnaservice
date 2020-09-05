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
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 16, top: 16, bottom: 8),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: size.height *0.250,
              child: new ListView.builder(
                itemCount: myData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DiscountItem(
                    product: myData[index],
                    themeColor: themeColor,
                  );
                },

              )),
        ],
      ),
    );
  }
}
