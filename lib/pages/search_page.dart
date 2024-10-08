import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/api_services.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/cart_provider.dart';
import 'package:khulnaservice/provider/category_provider.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/shopping_cart_page.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/provider/search_provider.dart';
import '../testFilter.dart';
import '../testPrDEtails.dart';
import 'package:khulnaservice/models/searchModel.dart';

class SearchPage extends StatefulWidget {
  var isBack;

  bool IsFloat;

  SearchPage(this.isBack, this.IsFloat);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String deneme = "Dursun";
  FetchData fetchData = FetchData();
  customWidget CustomWidget = customWidget();
  bool isLoading = true;
  var ProductLoading = "Loading";
  List<Datum> FirstList;
  List<Datum> SecondList = List<Datum>();

  getList() {
    FirstList = Provider.of<searchProvider>(context, listen: false)
        .searchData
        .products
        .data;

    for (int i = 0; i < FirstList.length; i++) {
      SecondList.add(FirstList[i]);
    }

    setState(() {
      if (FirstList.length == 0) {
        ProductLoading = "No more data";
      } else {
        ProductLoading = "";
      }
    });
  }

  var itemLength;

  @override
  void initState() {
    print(widget.isBack);

    fetchData.getCart(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    fetchData
        .searchData(
            context,
            "",
            indexNUm,
            Provider.of<CategoryProvider>(context, listen: false).minPrice,
            Provider.of<CategoryProvider>(context, listen: false).maxPrice)
        .then((value) {
      getList();

      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  _getMoreData() {
    setState(() {
      ProductLoading = "Loading";
    });
    indexNUm++;

    fetchData
        .searchData(
            context,
            myKeyWord,
            indexNUm,
            Provider.of<CategoryProvider>(context, listen: false).minPrice,
            Provider.of<CategoryProvider>(context, listen: false).maxPrice)
        .then((value) {
      getList();
//      isLoading = false;

      setState(() {});
    });
  }

  var myKeyWord = "";

  int indexNUm = 1;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 252, 252, 252),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isLoading
            ? SizedBox()
            : widget.IsFloat
                ? GestureDetector(
                    onTap: () {
                      Nav.route(context, ShoppingCartPage());
                    },
                    child: Container(
                      height: size.height * 0.08,
                      width: size.width * 0.18,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 5.0,
                                      spreadRadius: 1,
                                      offset: Offset(0.0, 1)),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  child: Badge(
                                    badgeColor: themeColor.getColor(),
                                    padding: EdgeInsets.all(4),
                                    badgeContent: Text(
                                      '${context.watch<CartProvider>().cartList.cart.length}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_shopping_cart_bottom.svg"),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Text(
                                  "৳${context.watch<CartProvider>().addAmount()}",
                                  style:
                                      TextStyle(color: themeColor.getColor()),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  widget.isBack
                      ? Container(
                          width: 32,
                          padding: const EdgeInsets.only(top: 8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              color: themeColor.getColor(),
                              size: 32,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      : SizedBox(
                          width: 32,
                        ),
                  Center(
                    child: Container(
                      width: ScreenUtil.getWidth(context) - 80,
                      margin: EdgeInsets.only(left: 22, top: 14),
                      padding: EdgeInsets.only(left: 18, right: 18),
                      height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: themeColor.getColor().withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 8.0,
                              spreadRadius: 1,
                              offset: Offset(0.0, 3))
                        ],
                        color: Theme.of(context).bottomAppBarColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/ic_search.svg",
                            color: Colors.black45,
                            height: 12,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 4),
                              height: 72,
                              child: TextFormField(
//                              onEditingComplete: () {
//                                print("asg");
//                              },
                                onFieldSubmitted: (v) {
                                  setState(() {
                                    SecondList = List<Datum>();
                                    ProductLoading = "Loading";
                                    myKeyWord = v;
                                  });

                                  fetchData
                                      .searchData(
                                    context,
                                    v,
                                    indexNUm,
                                    Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .minPrice,
                                    Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .maxPrice,
                                  )
                                      .then((value) {
                                    getList();
                                  });
                                },

                                controller: searchController,
                                key: _formKey,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Brand Search",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Color(0xFF5D6A78),
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: ScreenUtil.getWidth(context) - 20,
                margin: EdgeInsets.only(top: 24, left: 8),
                padding: EdgeInsets.only(left: 18, right: 22),
                height: 44,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: themeColor.getColor().withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 8.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 3))
                  ],
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          _sortingBottomSheet(SecondList);
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          child: Row(children: <Widget>[
                            RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Ionicons.ios_swap,
                                  size: 16,
                                )),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Sort",
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Color(0xFF5D6A78)),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    // Material(
                    //   color: Colors.white,
                    //   child: InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         isLoading = true;
                    //         SecondList = List<Datum>();
                    //       });
                    //
                    //       Navigator.push(
                    //         context,
                    //         PageRouteBuilder(
                    //           pageBuilder: (c, a1, a2) => TestFilter(
                    //             isFromSearch: true,
                    //           ),
                    //           transitionsBuilder: (c, anim, a2, child) =>
                    //               FadeTransition(opacity: anim, child: child),
                    //           transitionDuration: Duration(milliseconds: 280),
                    //         ),
                    //       ).then((value) {
                    //         indexNUm = 1;
                    //         fetchData
                    //             .searchData(
                    //                 context,
                    //                 myKeyWord,
                    //                 indexNUm,
                    //                 Provider.of<CategoryProvider>(context,
                    //                         listen: false)
                    //                     .minPrice,
                    //                 Provider.of<CategoryProvider>(context,
                    //                         listen: false)
                    //                     .maxPrice)
                    //             .then((value) {
                    //           getList();
                    //           isLoading = false;
                    //
                    //           setState(() {});
                    //         });
                    //       });
                    //     },
                    //     child: Container(
                    //       margin: EdgeInsets.all(12),
                    //       child: Row(children: <Widget>[
                    //         SvgPicture.asset(
                    //           "assets/icons/funnel.svg",
                    //           height: 14,
                    //           color: Color(0xFF5D6A78),
                    //         ),
                    //         SizedBox(
                    //           width: 3,
                    //         ),
                    //         Text(
                    //           "Filter",
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 13, color: Color(0xFF5D6A78)),
                    //         )
                    //       ]),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
//                  Container(
//                    margin: EdgeInsets.only(top: 18, left: 16),
//                    height: 42,
//                    child: ListView.builder(
//                      scrollDirection: Axis.horizontal,
//                      itemCount: prodcutListType.length,
//                      itemBuilder: (BuildContext context, int index) {
//                        return GestureDetector(
//                          onTap: () {},
//                          child: Container(
//                            margin: EdgeInsets.only(right: 8, bottom: 8),
//                            padding: EdgeInsets.only(left: 12, right: 12),
//                            decoration: BoxDecoration(
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.grey[200],
//                                    blurRadius: 8.0,
//                                    spreadRadius: 1,
//                                    offset: Offset(0.0, 3))
//                              ],
//                              color: Theme.of(context).bottomAppBarColor,
//                              borderRadius: BorderRadius.circular(24),
//                            ),
//                            child: Align(
//                                alignment: Alignment.center,
//                                child: Text(
//                                  prodcutListType[index],
//                                  style: GoogleFonts.poppins(
//                                      fontSize: 13, color: Color(0xFF5D6A78)),
//                                )),
//                          ),
//                        );
//                      },
//                    ),
//                  ),
              SizedBox(
                height: 32,
              ),
//                  productSearchItem(context, themeColor),
              isLoading
                  ? Center(
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: SecondList.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        if (index == SecondList.length) {
                          return Container(
                            height: 70,
                            child: Center(
                              child: Text(ProductLoading),
                            ),
                          );
                        }
                        return Center(
                          child: productSearchItem(
                              context,
                              SecondList[index],
                              themeColor,
                              SecondList[index].name,
                              SecondList[index].price,
                              SecondList[index].discountedPrice,
                              SecondList[index].id,
                              SecondList[index].image,
                              SecondList[index].stock,
                          ),
                        );
                      },
//                    crossAxisCount: 2,
//                    childAspectRatio: 0.7,
//                    children: <Widget>[
//                      productSearchItem(context, themeColor),
//
//                    ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  var first = 1;
  var second = 1;
  var third = 1;

  void _sortingBottomSheet(data) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Container(
                    margin: EdgeInsets.only(left: 36, top: 12),
                    child: Text(
                      "Sort Products By",
                      style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
                    )),
                InkWell(
                  onTap: () {
                    setState(() {
                      first = 2;
                      second = 1;
                      third = 1;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox$first.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Newest",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    data
                      ..sort((a, b) => double.parse(a.price)
                          .compareTo(double.parse(b.price)));
                    setState(() {
                      first = 1;
                      second = 2;
                      third = 1;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox$second.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Min Price",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    data
                      ..sort((a, b) => double.parse(b.price)
                          .compareTo(double.parse(a.price)));
                    setState(() {
                      first = 1;
                      second = 1;
                      third = 2;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 32, top: 20),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icons/checkbox$third.svg",
                            height: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Max Price",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFA1B1C2))),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        });
  }

  productSearchItem(BuildContext context, data, ThemeNotifier themeColor, name,
      price, diPrice, id, image,stock) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Nav.route(context, testPrDetails(data));
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
                              "https://khulnaservice.com/ims/?src=/uploads/product/${id}/front/cropped/${image}&p=small")),
                  width: ScreenUtil.getWidth(context) * 0.30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  height: 140,
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 170,
                        child: AutoSizeText(
                          '${name}',
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
                          double.parse(diPrice) != 0
                              ? Text(
                                  "${price}",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey[400],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                )
                              : Container(),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "৳ ${double.parse(diPrice) == 0 ? price : diPrice}",
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

                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CartProvider>().removeQuantity(id);
                            },
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Icon(
                                Icons.remove,
                                size: 15,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 22,
                            width: 40,
                            color: themeColor.getColor().withOpacity(0.2),
                            child: Center(
                              child: Text(context
                                          .watch<CartProvider>()
                                          .getQuantity(id) ==
                                      null
                                  ? "1"
                                  : context
                                      .watch<CartProvider>()
                                      .getQuantity(id)
                                      .toString()),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CartProvider>().addQuantity(id);
                            },
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                size: 15,
                              )),
                            ),
                          ),
                        ],
                      ),
                     stock==0? Container(
                       width: size.width * 0.35,
                       child: Center(
                         child: Text(
                           "Not In Stock",
                           style: GoogleFonts.poppins(
                               color: Colors.white,
                               fontSize: 10,
                               fontWeight: FontWeight.w400),
                         ),
                       ),
                       decoration: BoxDecoration(
                           color: themeColor.getColor(),
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
                     ) : Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.35,
                              child: GFButton(
                                onPressed: () {
                                  CustomWidget.myDiaglog(context);
                                  fetchData
                                      .getAddToCart(
                                          id.toString(),
                                          Provider.of<CartProvider>(context,
                                                          listen: false)
                                                      .getQuantity(id) ==
                                                  null
                                              ? "1"
                                              : Provider.of<CartProvider>(
                                                      context,
                                                      listen: false)
                                                  .getQuantity(id)
                                                  .toString())
                                      .then((value) {
                                    fetchData.getCart(context).then((value) {
                                      Navigator.of(context, rootNavigator: true).pop();
                                    }).catchError((onError) {
                                      Navigator.of(context, rootNavigator: true).pop();
                                      CustomWidget.myShowDialog(
                                          context, "Something went wrong");
                                    });
                                  }).catchError((onError) {

                                    Navigator.of(context, rootNavigator: true).pop();
                                    CustomWidget.myShowDialog(
                                        context, "Something went wrong");
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "assets/icons/ic_product_shopping_cart.svg",
                                  color: Colors.white,
                                  height: 12,
                                ),
                                child: Text(
                                  "Buy Now",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                                type: GFButtonType.transparent,
                              ),
                              decoration: BoxDecoration(
                                  color: themeColor.getColor(),
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

        ],
      ),
    );
  }
}
