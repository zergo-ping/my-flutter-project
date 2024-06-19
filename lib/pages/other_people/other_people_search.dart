import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteit/variables/variables.dart';

import '../../design/colors.dart';
import '../../design/images.dart';
import 'add_friends.dart';



class Other_search extends StatefulWidget {
  const Other_search({super.key});

  @override
  State<Other_search> createState() => _HomeState();
}

class _HomeState extends State<Other_search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: []),
      width: 298,
      height: 48,
      child: TextFormField(
        onChanged: (val){
          setState(() {
            cardUserName=val;
          });
        },
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

