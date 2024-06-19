import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/pages/other_people/other_people_search.dart';
import 'package:noteit/pages/other_people/search.dart';
import '../../design/colors.dart';
import '../../design/images.dart';
import 'add_friends.dart';

class OtherPeopleHead extends StatelessWidget {
  const OtherPeopleHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(top: 25, right: 13)),
          Container(
            decoration: BoxDecoration(boxShadow: []),
            width: 298,
            height: 48,
            child: TextField(
              onChanged: (val) {},
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
          ),
          Padding(padding: EdgeInsets.only(right: 0)),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const AddFriends()));
            },
            icon: addFriendsImage,
          )
        ],
      ))
    ]);
  }
}
