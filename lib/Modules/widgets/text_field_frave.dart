import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextFormFrave extends StatelessWidget {

  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget prefixIcon;

  const TextFormFrave({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 17),
      cursorColor: Color(0xff002C8B),
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
        filled: true,
        fillColor: Color(0xfff5f5f5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Color(0xffF5F5F5))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Color(0xffF5F5F5))),
        hintText: hintText,
        prefixIcon: prefixIcon
      ),
      validator: validator,
    );
  }
}