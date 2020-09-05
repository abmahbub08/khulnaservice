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
    var size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          productListTitleBar,
          Container(
              height: size.height *0.250,
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
        ],
      ),
    );
  }
}
