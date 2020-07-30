import 'package:flutter/material.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/product_card.dart';
import 'package:khulnaservice/widgets/homepage/product_list_titlebar.dart';

class ProductList extends StatelessWidget {
  ProductList(
      {Key key,
      @required this.themeColor,
      this.productListTitleBar,
      this.product})
      : super(key: key);
  List<Product> product;
  final ThemeNotifier themeColor;
  final ProductListTitleBar productListTitleBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: 285.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: product.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: product[index],
                      themeColor: themeColor,
                      imageUrl: "prodcut1.png");
                },
              )),
//          Container(
//              height: 285.0,
//              child: ListView(
//                scrollDirection: Axis.horizontal,
//                children: <Widget>[
//                  ProductCard(themeColor: themeColor, imageUrl: "prodcut1.png"),
//                  ProductCard(themeColor: themeColor, imageUrl: "prodcut2.png"),
//                  ProductCard(themeColor: themeColor, imageUrl: "prodcut3.png"),
//                  ProductCard(themeColor: themeColor, imageUrl: "prodcut4.png"),
//                  ProductCard(themeColor: themeColor, imageUrl: "prodcut5.png"),
//                ],
//              )),
        ],
      ),
    );
  }
}
