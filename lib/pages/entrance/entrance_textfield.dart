
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../design/colors.dart';

class MyTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 55,
      width: 360,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: hintColor,fontFamily: "Inter",fontSize: 16),
          hintText: hintText,
          filled: true,
          fillColor: lightWhiteColor,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: whiteColor,
              ),
              borderRadius: BorderRadius.circular(26)),
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(26)),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}