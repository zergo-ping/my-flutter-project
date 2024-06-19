import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/pages/other_people/other_people_search.dart';
import '../../design/colors.dart';
import '../../design/images.dart';
import 'add_friends.dart';
import 'other_people_main.dart';

class AddFriendsHead extends StatelessWidget {
  const AddFriendsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.only(top: 25,right: 13)),
              IconButton(onPressed: (){
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                        const OtherPeopleProfile()));
              }, icon: arrowImage),
              Other_search(),
            ],
          ))
    ]);
  }
}
