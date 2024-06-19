import 'package:flutter/material.dart';
import '../../design/colors.dart';
import '../../design/images.dart';

class EntranceHead extends StatelessWidget {
  const EntranceHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Column(
          children: [
          Padding(padding: EdgeInsets.only(top: 25)),
          logo2Image,
          Padding(padding: EdgeInsets.only(top: 25)),
          Text("Отмечай мечты, достигай цели", style: TextStyle(fontSize: 16,color:deepPurpleColor),)
        ],
      ))
    ]);
  }
}
