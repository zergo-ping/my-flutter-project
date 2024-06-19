import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteit/variables/variables.dart';

import '../../design/colors.dart';
import '../../design/images.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _HomeState();
}

class _HomeState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: []),
      padding: EdgeInsets.only(top: 0, left: 17),
      width: 325,
      height: 48,
      child: TextFormField(
        controller: TextEditingController(),
        decoration: InputDecoration(
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
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: searchImage,
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}

