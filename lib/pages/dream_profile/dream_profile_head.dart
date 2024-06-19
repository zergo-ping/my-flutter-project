import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../design/colors.dart';
import '../../design/images.dart';

class DreamProfileHead extends StatelessWidget {
  const DreamProfileHead({super.key});

  void signUserOut()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(top: 25)),
            logo2Image,
            Padding(padding:EdgeInsets.only(right: 115)),
            IconButton(onPressed: signUserOut,icon: profileImage,)
        ],
      ))
    ]);
  }
}