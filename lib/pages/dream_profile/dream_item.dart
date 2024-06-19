
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteit/variables/variables.dart';

import '../../design/colors.dart';
import '../../design/images.dart';

class DreamItem extends StatefulWidget {
  const DreamItem({super.key});

  @override
  State<DreamItem> createState() => CreateCarddd();
}

class CreateCarddd extends State<DreamItem> {
  bool valueDone = true;
  String name="";
  @override
  Widget build(BuildContext context) {
    return Card(
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
                        user,
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
                      setState(() {
                        valueDone = !valueDone;
                        print(valueDone);
                      });
                    },
                    icon: valueDone == true ? doneImage : doneImage2),
                IconButton(
                    onPressed: () {}, icon: editImage)
              ],
            )
          ]),
    );
  }

  Card enter(BuildContext context) {
    return Card(
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
                      setState(() {
                        valueDone=!valueDone;
                      });

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