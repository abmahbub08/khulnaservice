import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/provider/place_order_provider.dart';
import 'package:khulnaservice/utils/drop_down_menu/find_dropdown.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:khulnaservice/widgets/new_adress_input.dart';
import 'package:provider/provider.dart';

class NewAddressPage extends StatefulWidget {
  var method;
  bool dataLoad;

  NewAddressPage(this.method, this.dataLoad);

  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  bool asTabs = false;
  String selectedValue;
  String preselectedValue = "dolor sit";
  bool same = false;
  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];
  FetchData fetchData = FetchData();
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqu";

  TextEditingController phoneCont = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    @override
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(DropdownMenuItem(
            child: Text("add"),
            value: "add",
          ));
        }
        wordPair = "";
      }
    });
    getData();
    super.initState();

    super.initState();
  }

  getData() {
    var data =
        Provider.of<placeOrderProvider>(context, listen: false).searchData;

    if (widget.method == 2) {
      try {
        phoneCont.text = data.billingAddress.phone;
        address1.text = data.billingAddress.address1;
        address2.text = data.billingAddress.address2;
        Division = data.billingAddress.city.name;
        District = data.billingAddress.state.name;
        StateId = data.billingAddress.state.id;
        CityId = data.billingAddress.city.id;
      } catch (e) {}
    } else {
      try {
        phoneCont.text = data.shippingAddress.phone;
        address1.text = data.shippingAddress.address1;
        address2.text = data.shippingAddress.address2;
        Division = data.shippingAddress.city.name;
        District = data.shippingAddress.state.name;
        StateId = data.shippingAddress.state.id;
        CityId = data.shippingAddress.city.id;
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    var data = Provider.of<placeOrderProvider>(context, listen: false)
        .searchData
        .divisions;
    return SafeArea(
      child: Scaffold(

          backgroundColor: Color(0xFFFCFCFC),
          body: Container(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Provide ${widget.method == 2 ? "Billing" : "Shipping"} Address",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Color(0xFF5D6A78)),
                  ),
                  Container(
                      width: 28,
                      child: Divider(
                        color: themeColor.getColor(),
                        height: 3,
                        thickness: 2,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: <Widget>[
                      NewAddressInput(
                        textEditing: phoneCont,
                        labelText: "Phone",
                        hintText: '',
                        isEmail: false,
                        validator: (String value) {},
                        onSaved: (String value) {
//                        model.email = value;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      NewAddressInput(
                        textEditing: address1,
                        labelText: "Address Line 1",
                        hintText: '',
                        isEmail: true,
                        validator: (String value) {},
                        onSaved: (String value) {
//                        model.email = value;
                        },
                      ),

//
                      SizedBox(
                        height: 16,
                      ),
                      NewAddressInput(
                        textEditing: address2,
                        labelText: "Address Line 2",
                        hintText: '',
                        isEmail: true,
                        validator: (String value) {},
                        onSaved: (String value) {
//                        model.email = value;
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      FindDropdown(
                          items: data.map((e) {
                            return e.name;
                          }).toList(),
                          onChanged: (String item) {
                            setState(() {
                              StateId = data
                                  .firstWhere((element) => element.name == item)
                                  .id;
                            });
                          },
                          selectedItem: Division,
                          isUnderLine: true),
                      SizedBox(
                        height: 32,
                      ),
                      FindDropdown(
                          items: data[StateId - 1]
                              .districts
                              .map((e) => e.name)
                              .toList(),
                          onChanged: (String item) {
                            setState(() {
                              CityId = data[StateId - 1]
                                  .districts
                                  .firstWhere((element) => element.name == item)
                                  .id;
                            });
                          },
                          selectedItem: District,
                          isUnderLine: true),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: same,
                              onChanged: (v) {
                                setState(() {
                                  same = v;
                                });
                              }),
                          Text("Make shipping and billing address same")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
//            Nav.routeReplacement(context, CreditCartPage());

                          if (phoneCont.text.isEmpty) {
                            Customwidget.myShowDialog(context, "Set a number");
                          } else if (address1.text.isEmpty) {
                            Customwidget.myShowDialog(context, "Fill address");
                          } else {
                            Customwidget.myDiaglog(context);
                            fetchData
                                .addressUpdate(
                                    context,
                                    phoneCont.text,
                                    address1.text,
                                    address2.text,
                                    StateId.toString(),
                                    CityId.toString(),
                                    widget.method.toString(),
                                    same == false ? 0.toString() : 1.toString())
                                .then((value) {
                              fetchData
                                  .getPlaceOrderData(context)
                                  .then((value) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Dialog(
                                        child: Container(
                                            color: Colors.transparent,
                                            height: 170,
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 160,
                                                    child: Center(
                                                        child: Text(
                                                            "Address Updated"))),
                                                Divider(),
                                                RaisedButton(
                                                  color: themeColor.getColor(),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ))));
                              }).catchError((onError) {
                                print(onError);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Customwidget.myShowDialog(
                                    context, "Something went wrong!");
                              });
                            }).catchError((onError) {
                              print(onError);
                              Navigator.of(context, rootNavigator: true).pop();
                              Customwidget.myShowDialog(
                                  context, "Something went wrong!");
                            });
                          }
                        },
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Save",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                          color: themeColor.getColor(),
                          height: 42,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  int StateId = 2;
  int CityId = 0;
  var Division = "Division";
  var District = "District";
  customWidget Customwidget = customWidget();
}
