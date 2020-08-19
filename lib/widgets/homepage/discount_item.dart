import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/models/CategoryPageModel.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/testPrDEtails.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:like_button/like_button.dart';
import 'package:khulnaservice/pages/product_detail.dart';
import 'package:khulnaservice/pages/shopping_cart_page.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:provider/provider.dart';

import '../../config.dart';

class DiscountItem extends StatelessWidget {
  final themeColor;
  final String imageUrl;
  Product product;
  FetchData fetchData = FetchData();
  customWidget CustomWidget = customWidget();

  DiscountItem({Key key, this.themeColor, this.imageUrl, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.route(
            context,
            testPrDetails(Datum(
              image: product.image,
              name: product.name,
              backImage: product.backImage,
              bannedAt: product.bannedAt,
              commentStats: product.commentStats,
              commission: product.commission,
              createdAt: product.createdAt,
              decorationState: product.decorationState,
              deletedAt: product.deletedAt,
              description: product.description,
              discountedPrice: product.discountedPrice,
              featured: product.featured,
              features: product.features,
              id: product.id,
              manufacturerId: product.manufacturerId,
              price: product.price,
              productFeatures: product.productFeatures,
              returnPolicy: product.returnPolicy,
              shipping: product.shipping,
              sku: product.sku,
              state: product.state,
              stock: product.stock,
              storeId: product.storeId,
              taxFree: product.taxFree,
              updatedAt: product.updatedAt,
              variationCount: product.variationCount,
              vat: product.vat,
              visited: product.visited,
              manufacturer: Manufacturer(),
              categories: List<Category>(),
            )));
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, left: 16, bottom: 8),
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
            width: ScreenUtil.getWidth(context) / 1.24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/produload.jpg",
                          image:
                              "https://khulnaservice.com/ims/?src=/uploads/product/${product.id}/front/cropped/${product.image}&p=small")),
                  width: ScreenUtil.getWidth(context) * 0.30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 160,
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 170,
                        child: AutoSizeText(
                          '${product.name}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          minFontSize: 11,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          RatingBar(
                            ignoreGestures: true,
                            initialRating: 5,
                            itemSize: 14.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Ionicons.ios_star,
                              color: themeColor.getColor(),
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
//                          Text(
//                            "(395)",
//                            style: GoogleFonts.poppins(
//                                fontSize: 9, fontWeight: FontWeight.w400),
//                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          double.parse(product.discountedPrice) != 0
                              ? Text(
                                  "${product.price}",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                )
                              : Container(),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "৳ ${double.parse(product.discountedPrice) == 0 ? product.price : product.discountedPrice}",
                            style: GoogleFonts.poppins(
                                color: themeColor.getColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
//                      Text(
//                        "Free Cargo",
//                        style: GoogleFonts.poppins(
//                            color: themeColor.getColor(),
//                            fontSize: 10,
//                            fontWeight: FontWeight.w300),
//                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150,
                              child: GFButton(
                                onPressed: () {
                                  CustomWidget.myDiaglog(context);
                                  fetchData
                                      .getAddToCart(product.id.toString(), "1")
                                      .then((value) {
                                    fetchData.getCart(context).then((value) {
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/ic_product_shopping_cart.svg",
                                  height: 12,
                                ),
                                child: Text(
                                  "Add to Basket",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF5D6A78),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                                type: GFButtonType.transparent,
                              ),
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
                              height: 32,
                              margin: EdgeInsets.only(right: 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
//          Positioned(
//            bottom: 16,
//            right: 8,
//            child: Container(
//              child: GFButton(
//                onPressed: () {
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                      backgroundColor: mainColor,
//                      content: Text('Product added to cart')));
//                  Nav.route(context, ShoppingCartPage());
//                },
//                icon: SvgPicture.asset(
//                  "assets/icons/ic_product_shopping_cart.svg",
//                  height: 12,
//                ),
//                child: Text(
//                  "Add to Basket",
//                  style: GoogleFonts.poppins(
//                      color: Color(0xFF5D6A78),
//                      fontSize: 10,
//                      fontWeight: FontWeight.w400),
//                ),
//                type: GFButtonType.transparent,
//              ),
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(3),
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(.2),
//                      blurRadius: 6.0, // soften the shadow
//                      spreadRadius: 0.0, //extend the shadow
//                      offset: Offset(
//                        0.0, // Move to right 10  horizontally
//                        1.0, // Move to bottom 10 Vertically
//                      ),
//                    )
//                  ]),
//              height: 32,
//              margin: EdgeInsets.only(right: 2),
//            ),
//          )
        ],
      ),
    );
  }
}
