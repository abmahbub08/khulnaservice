import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/category_provider.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/dummy_data/category.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/utils/vertical_tab/vertical_tab.dart';
import 'package:provider/provider.dart';

import '../testProduct.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FetchData fetchData = FetchData();

  getCategory() async {
//    var res = await CallApi().getData('allCategories');
  }

  var indexTab = 0;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    print(context
        .watch<CategoryProvider>()
        .tabName
        .length);
    return Scaffold(
        backgroundColor: greyBackground,
        body: context
            .watch<CategoryProvider>()
            .tabName
            .length == 0
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
            : ListView.builder(
            itemCount: context
                .watch<CategoryProvider>()
                .tabName
                .length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                onExpansionChanged: (v) {
                  setState(() {
                    indexTab = index;
                  });

                },
                title:
                Text(context
                    .watch<CategoryProvider>()
                    .tabName[index]),
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: greyBackground,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: context
                          .watch<CategoryProvider>()
                          .myCategory
                          .category[indexTab]
                          .children
                          .length,
                      itemBuilder: (context, index) {
                        return expansionTile(
                            themeColor,
                            context
                                .watch<CategoryProvider>()
                                .myCategory
                                .category[indexTab]
                                .children[index]
                                .name
                                .toString(),
                            index);
                      },
                    ),
                  )
                ],
              );
              Text(context
                  .watch<CategoryProvider>()
                  .tabName[index]);
            })

      // VerticalTabs(
      //         indicatorColor: themeColor.getColor(),
      //         selectedTabBackgroundColor: whiteColor,
      //         tabBackgroundColor: themeColor.getColor(),
      //         backgroundColor: greyBackground,
      //         direction: TextDirection.rtl,
      //         tabsWidth: 48,
      //         onSelect: (data) {
      //           Future.delayed(Duration(microseconds: 10), () {
      //             setState(() {
      //               indexTab = data;
      //             });
      //           });
      //         },
      //         tabsTitle: context.watch<CategoryProvider>().tabName,
      //         tabs: context
      //             .watch<CategoryProvider>()
      //             .tabName
      //             .map((e) => Tab(
      //                   icon: Icon(Icons.add),
      //                 ))
      //             .toList(),
      //         contents: context
      //             .watch<CategoryProvider>()
      //             .tabName
      //             .map((e) => tabsContent(themeColor, "s"))
      //             .toList(),
      //       ),
    );
  }

  Widget tabsContent(ThemeNotifier themeColor, String caption,
      [String description = '']) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      color: greyBackground,
      child: ListView.builder(
        itemCount: context
            .watch<CategoryProvider>()
            .myCategory
            .category[indexTab]
            .children
            .length,
        itemBuilder: (context, index) {
          return expansionTile(
              themeColor,
              context
                  .watch<CategoryProvider>()
                  .myCategory
                  .category[indexTab]
                  .children[index]
                  .name
                  .toString(),
              index);
        },
      ),
    );
  }

  Widget expansionTile(themeColor, String title, indexThird) {
    return Theme(
      data: ThemeData(accentColor: themeColor.getColor()),
      child: ExpansionTile(
        onExpansionChanged: (ss) {
          if (Provider
              .of<CategoryProvider>(context, listen: false)
              .myCategory
              .category[indexTab]
              .children[indexThird]
              .children
              .length ==
              0) {
            Provider.of<CategoryProvider>(context, listen: false).addCatSlug(
                Provider
                    .of<CategoryProvider>(context, listen: false)
                    .myCategory
                    .category[indexTab]
                    .children[indexThird]
                    .slug);

            Nav.route(context, testProduct());
          }
        },
        title: Text(
          title,
          style: GoogleFonts.poppins(color: Color(0xFF5D6A78)),
          textDirection: TextDirection.ltr,
        ),

        children: [
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                // Generate 100 widgets that display their index in the List.
                children: List.generate(
                    Provider
                        .of<CategoryProvider>(context, listen: false)
                        .myCategory
                        .category[indexTab]
                        .children[indexThird]
                        .children
                        .length, (index) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              print(Provider
                                  .of<CategoryProvider>(context,
                                  listen: false)
                                  .myCategory
                                  .category[indexTab]
                                  .children[indexThird]
                                  .children[index]
                                  .slug);

                              Provider.of<CategoryProvider>(context,
                                  listen: false)
                                  .addCatSlug(Provider
                                  .of<CategoryProvider>(
                                  context,
                                  listen: false)
                                  .myCategory
                                  .category[indexTab]
                                  .children[indexThird]
                                  .children[index]
                                  .slug);

                              Nav.route(context, testProduct());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 64, top: 2.0, bottom: 1.0),
                              child: AutoSizeText(
                                Provider
                                    .of<CategoryProvider>(context,
                                    listen: false)
                                    .myCategory
                                    .category[indexTab]
                                    .children[indexThird]
                                    .children[index]
                                    .name,
                                textDirection: TextDirection.ltr,
                                maxLines: 2,
                                minFontSize: 7,
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF5D6A78),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                      ),
                      Divider()
                    ],
                  );
                }),
              )
            ],
          )
        ],
      ),
    );
  }

//

}
