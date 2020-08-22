import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/api/fetchdata.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/theme_notifier.dart';
import 'package:khulnaservice/widgets/commons/textfield_bottomline.dart';
import 'package:khulnaservice/widgets/customWdiget.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class EditImage extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    final _formKey = GlobalKey<FormState>();
    bool passwordVisible = false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFCFCFC),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () {
            CustomWidget.myDiaglog(context);
            fetchData.imageUpdate(filePath).then((value) {
              Navigator.pop(context);
              CustomWidget.myShowDialog(context, "Profile Image Updated");
            }).catchError((onError) {
              Navigator.pop(context);
              CustomWidget.myShowDialog(context, "Something went wrong");
            });
          },
          child: isLoading
              ? Center()
              : Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Save",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  height: 42,
                  decoration: BoxDecoration(
                      color: themeColor.getColor(),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Change Image",
                  style: GoogleFonts.poppins(fontSize: 18, color: textColor),
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
                GestureDetector(
                  onTap: getFile,
                  child: Container(
                      height: 220,
                      width: 220,
                      color: Colors.grey[300],
                      child: filePath == null
                          ? Icon(
                              Icons.add,
                              size: 50,
                            )
                          : Image.file(
                              File(filePath),
                              fit: BoxFit.cover,
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FetchData fetchData = FetchData();
  customWidget CustomWidget = customWidget();
  TextEditingController nameController = TextEditingController();

  getFile() async {
    filePath = await FilePicker.getFilePath(
        type: FileType.image, allowCompression: true);
    setState(() {});
  }

  var filePath;
}
