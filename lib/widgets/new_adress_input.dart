import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAddressInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final TextEditingController textEditing;

  NewAddressInput(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.labelText,
      this.suffixIcon,
      this.textEditing});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditing,
      decoration: InputDecoration(
          hintText: hintText,
          labelStyle: GoogleFonts.poppins(fontSize: 12),
          helperStyle: GoogleFonts.poppins(fontSize: 12),
          hintStyle: GoogleFonts.poppins(fontSize: 12),
          labelText: labelText),
      validator: validator,
      onSaved: onSaved,
      keyboardType: isEmail ? TextInputType.text : TextInputType.number,
    );
  }
}
