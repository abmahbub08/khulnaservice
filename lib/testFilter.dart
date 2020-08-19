import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/provider/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:khulnaservice/pages/filter_detail_inner_page.dart';
import 'package:khulnaservice/pages/search_page.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/navigator.dart';
import 'package:khulnaservice/utils/screen.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';

class TestFilter extends StatefulWidget {
  @override
  _TestFilterState createState() => _TestFilterState();
}

class _TestFilterState extends State<TestFilter> {
  var switch1 = true;
  var switch2 = false;

  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    minPrice.text =
        Provider.of<CategoryProvider>(context, listen: false).minPrice;
    maxPrice.text =
        Provider.of<CategoryProvider>(context, listen: false).maxPrice;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );

    var manList = Provider.of<CategoryProvider>(context, listen: false)
        .getPage()
        .manufacturers;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () {
            context
                .read<CategoryProvider>()
                .addMinAndMaxPrice(minPrice.text, maxPrice.text);
            Navigator.pop(context, maxPrice.text);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
                color: Color(0xFF5D6A78)),
            height: 42,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Apply",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                )),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(bottom: 12),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                        onTap: () {
                          Nav.route(context, FilterDetalInnerPage());
                        },
                        title: Text("Min Price",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Color(0xFFA1B1C2))),
                        subtitle: TextFormField(
                          controller: minPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Type your min price",
                              hintStyle: TextStyle(
                                  fontSize: 15, color: Colors.grey[400]),
                              border: InputBorder.none),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                        onTap: () {
                          Nav.route(context, FilterDetalInnerPage());
                        },
                        title: Text("Max Price",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Color(0xFFA1B1C2))),
                        subtitle: TextFormField(
                          controller: maxPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Type your max price",
                              hintStyle: TextStyle(
                                  fontSize: 15, color: Colors.grey[400]),
                              border: InputBorder.none),
                        )),
                  ),
                ),
//                Container(
//                  height: 54,
//                  child: ListTile(
//                    title: Text(
//                      "Daily",
//                      style:
//                      GoogleFonts.poppins(fontSize: 14, color: textColor),
//                    ),
//                    trailing: Transform.scale(
//                      scale: 0.7,
//                      child: CupertinoSwitch(
//                        activeColor: themeColor.getColor(),
//                        value: switch1,
//                        onChanged: (bool value) {
//                          setState(() {
//                            switch1 = value;
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                ),
//                Container(
//                  height: 54,
//                  child: ListTile(
//                    title: Text("Free Cargo",
//                        style: GoogleFonts.poppins(
//                            fontSize: 14, color: textColor)),
//                    trailing: Transform.scale(
//                      scale: 0.7,
//                      child: CupertinoSwitch(
//                        activeColor: themeColor.getColor(),
//                        value: switch2,
//                        onChanged: (bool value) {
//                          setState(() {
//                            switch2 = value;
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                ),
                Divider(),
                Container(
                  height: 54,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text("Menufacture",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Color(0xFFA1B1C2))),
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, position) {
                      return Container(
                        height: 40,
                        child: Transform.scale(
                          scale: 0.9,
                          child: RadioListTile(
                            value: false,
                            title: Text(
                              manList[position].name,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Color(0xFFA1B1C2)),
                            ),
                            groupValue: null,
                            onChanged: (bool value) {},
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildItem(String title, String subTitle) {
    return Container(
      height: 54,
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          onTap: () {
            Nav.route(context, FilterDetalInnerPage());
          },
          title: Text(title,
              style:
                  GoogleFonts.poppins(fontSize: 14, color: Color(0xFFA1B1C2))),
          subtitle: Text(subTitle,
              style: GoogleFonts.poppins(fontSize: 12, color: textColor)),
        ),
      ),
    );
  }
}
