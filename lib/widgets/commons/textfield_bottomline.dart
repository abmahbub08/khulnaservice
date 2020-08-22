import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulnaservice/utils/commons/colors.dart';
import 'package:khulnaservice/utils/screen.dart';

class MyTextFormFieldLine extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;
  TextEditingController controller;

  MyTextFormFieldLine(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.labelText,
      this.suffixIcon,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getWidth(context) / 1.5,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: textColor),
          contentPadding: EdgeInsets.all(15.0),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: textColor)),
          labelText: labelText,
          filled: true,
          suffixIcon: this.suffixIcon,
          fillColor: Color(0xFFFCFCFC),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
