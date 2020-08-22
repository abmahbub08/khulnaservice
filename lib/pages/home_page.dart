import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/homepage_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/product_detail.dart';
import 'package:khulnaservice/utils/dummy_data/discountImages.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/homepage/category_list_view.dart';
import 'package:khulnaservice/widgets/homepage/discount_list.dart';
import 'package:khulnaservice/widgets/homepage/product_list.dart';
import 'package:khulnaservice/widgets/homepage/product_list_titlebar.dart';
import 'package:khulnaservice/widgets/homepage/search_box.dart';
import 'package:khulnaservice/widgets/homepage/slider_dot.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _carouselCurrentPage = 0;
  FetchData fetchData = FetchData();

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String value) {
      changeLocale(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    var MyData =
        Provider.of<HomePageProvider>(context, listen: false).homePageData;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        body: ListView(
          children: <Widget>[
            SearchBox(),
//              FlatButton(
//                onPressed: () {
//                  _onActionSheetPress(context);
//                },
//                child: Text(translate('button.change_language')),
//              ),
//                CategoryListView(),
            InkWell(
              onTap: () {
                Nav.route(context, ProductDetailPage());
              },
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: false,
                    height: 175,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _carouselCurrentPage = index;
                      });
                    }),
              ),
            ),
            SliderDot(current: _carouselCurrentPage),
            DiscountList(
              myData: MyData.featuredProducts,
              image: MyData.featuredProducts[0].image,
              title: MyData.featuredProducts[0].name,
              themeColor: themeColor,
              productListTitleBar: ProductListTitleBar(
                themeColor: themeColor,
                title: "Feature",
                isCountShow: true,
              ),
            ),
            SizedBox(
              height: 8,
            ),

            ListView.builder(
                shrinkWrap: true,
                itemCount: MyData.homeCategories.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductList(
                    product: MyData.homeCategories[index].products,
                    themeColor: themeColor,
                    productListTitleBar: ProductListTitleBar(
                      themeColor: themeColor,
                      title: "${MyData.homeCategories[index].name}",
                      isCountShow: false,
                    ),
                  );
                }),

            SizedBox(
              height: 8,
            ),
//                InkWell(
//                  onTap: () {
//                    Nav.route(context, ProductDetailPage());
//                  },
//                  child: CarouselSlider(
//                    items: imageSliders,
//                    options: CarouselOptions(
//                        autoPlay: false,
//                        height: 175,
//                        viewportFraction: 1.0,
//                        enlargeCenterPage: false,
//                        onPageChanged: (index, reason) {
//                          setState(() {
//                            _carouselCurrentPage = index;
//                          });
//                        }),
//                  ),
//                ),
//                SizedBox(
//                  height: 8,
//                ),
//                ProductList(
//                  themeColor: themeColor,
//                  productListTitleBar: ProductListTitleBar(
//                    themeColor: themeColor,
//                    title: "Most Top Rated",
//                    isCountShow: false,
//                  ),
//                ),
//                DiscountList(
//                  themeColor: themeColor,
//                  productListTitleBar: ProductListTitleBar(
//                    themeColor: themeColor,
//                    title: "Low-Priced Products",
//                    isCountShow: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 8,
//                ),
//                ProductList(
//                  themeColor: themeColor,
//                  productListTitleBar: ProductListTitleBar(
//                    themeColor: themeColor,
//                    title: "Most recently looked",
//                    isCountShow: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 36,
//                ),
          ],
        ));
  }
}
