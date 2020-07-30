import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/models/CategoryPageModel.dart';
import 'package:khulnaservice/models/homePageDataModel.dart';
import 'package:khulnaservice/pages/product_detail.dart';
import 'package:khulnaservice/pages/shopping_cart_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';

import '../../config.dart';
import '../../testPrDEtails.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key key, @required this.themeColor, this.imageUrl, this.product})
      : super(key: key);

  final ThemeNotifier themeColor;
  final String imageUrl;
  Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
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
          child: Container(
            width: ScreenUtil.getWidth(context) / 2,
            margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 170,
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: 300,
                            height: 170,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/produload.jpg",
                                    image:
                                        "https://khulnaservice.com/ims/?src=/uploads/product/${product.id}/front/cropped/${product.image}&p=small"))),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            width: 140,
                            height: 20,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "FREE CARGO",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
//                        Positioned(
//                          top: 0,
//                          right: 8,
//                          child: Container(
//                            height: 38,
//                            width: 32,
//                            decoration: BoxDecoration(
//                                color: Colors.white.withOpacity(0.4),
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(8),
//                                    bottomRight: Radius.circular(8))),
//                            child: Icon(
//                              Icons.favorite,
//                              color: Colors.white,
//                              size: 18,
//                            ),
//                          ),
//                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 204.0,
                    padding: EdgeInsets.only(left: 10, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 170,
                          child: AutoSizeText(
                            product.name,
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
                        SizedBox(
                          height: 2,
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
//                            Text(
//                              "(395)",
//                              style: GoogleFonts.poppins(
//                                  fontSize: 9, fontWeight: FontWeight.w400),
//                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                double.parse(product.discountedPrice) == 0
                                    ? SizedBox(
                                        height: 16,
                                      )
                                    : Text(
                                        "${double.parse(product.price).toStringAsFixed(1)}",
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                Text(
                                  "${double.parse(product.discountedPrice) == 0 ? double.parse(product.price).toStringAsFixed(1) : double.parse(product.discountedPrice).toStringAsFixed(1)}",
                                  style: GoogleFonts.poppins(
                                      color: themeColor.getColor(),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 22,
          right: 22,
          child: InkWell(
            onTap: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: mainColor,
                  content: Text('Product added to cart')));
              Nav.route(context, ShoppingCartPage());
            },
            child: Container(
              padding: EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 8),
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
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/ic_product_shopping_cart.svg",
                    height: 12,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Add to Basket",
                    style: GoogleFonts.poppins(
                        color: Color(0xFF5D6A78),
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
