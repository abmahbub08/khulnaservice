import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/models/cartListModel.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/utils/drop_down_menu/find_dropdown.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatefulWidget {
  const ShoppingCartItem(
      {Key key, @required this.themeColor, this.imageUrl, this.cart})
      : super(key: key);

  final ThemeNotifier themeColor;
  final String imageUrl;
  final Cart cart;

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8, left: 24, bottom: 8, right: 24),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://khulnaservice.com/ims/?src=/uploads/product/${widget.cart.id}/front/cropped/${widget.cart.attributes.image}&p=small",
                      fit: BoxFit.cover,
                      width: ScreenUtil.getWidth(context) * 0.30,
                    )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 160,
                padding: EdgeInsets.all(10),
              ),
              Container(
                width: ScreenUtil.getWidth(context) / 2,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoSizeText(
                      widget.cart.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Color(0xFF5D6A78),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      minFontSize: 11,
                    ),
                    Row(
                      children: <Widget>[
                        double.parse(widget.cart.attributes.discountedPrice) == 0
                            ? SizedBox()
                            : Text(
                                "${widget.cart.attributes.price}",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                        SizedBox(
                          width: 4,
                        ),
                        double.parse(widget.cart.attributes.discountedPrice) == 0
                            ? Text(
                                "${widget.cart.price}",
                                style: GoogleFonts.poppins(
                                    color: widget.themeColor.getColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              )
                            : Text(
                                "${widget.cart.attributes.discountedPrice}",
                                style: GoogleFonts.poppins(
                                    color: widget.themeColor.getColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 12,
          child: IconButton(
            icon: Icon(
              Feather.trash,
              size: 18,
              color: Color(0xFF5D6A78),
            ),
            onPressed: () {

//              setState(() {
//                Provider.of<CartProvider>(context, listen: false)
//                    .cartList
//                    .cart
//                    .removeLast();
//              });
            },
          ),
        ),
        Positioned(
          bottom: 24,
          right: 32,
          child: Container(
            width: 48,
            margin: EdgeInsets.only(top: 26),
            child: Align(
              alignment: Alignment.centerRight,
              child: FindDropdown(
                items: ["1", "2", "3", "4"],
                onChanged: (String item) => print(item),
                selectedItem: "1",
                isUnderLine: false,
              ),
            ),
          ),
        )
      ],
    );
  }
}
