import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../design/colors.dart';
import '../../design/images.dart';
import '../../variables/variables.dart';
import 'bucket_profile_page.dart';

class Item {

  int index = 0;
  String name = "";
  bool valueDone = true;

  Card enter(BuildContext context) {
    return  Card(
      color: lightWhiteColor,
      elevation: 0,
      child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              color: lightWhiteColor,
            ),
            SizedBox(
              width: 225,
              child: TextButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        textDirection:
                        TextDirection.rtl,
                        name,
                        style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: blackColor)),
                  )),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {

                    },
                    icon: valueDone == true ? doneImage : doneImage2),
                IconButton(
                    onPressed: () {}, icon: editImage)
              ],
            )
          ]),
    );
  }

}
