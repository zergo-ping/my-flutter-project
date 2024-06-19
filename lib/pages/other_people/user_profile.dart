import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteit/design/colors.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/other_people/user_dreams.dart';
import 'package:noteit/pages/other_people/user_list_buckets.dart';
import 'package:noteit/variables/variables.dart';

import 'add_friends.dart';

class UserProfile extends StatefulWidget {
  final name;
  final image;
  final email;
  UserProfile(this.name, this.image,this.email);

  @override
  State<UserProfile> createState() => _UserProfile(name, image,email);
}

class _UserProfile extends State<UserProfile> {
  bool valueColor=true;
  final name;
  final image;
  final email;
  _UserProfile(this.name, this.image,this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          toolbarHeight: 100,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                          const AddFriends()));
                },
                icon: arrowImage,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                    width: 140,
                    height: 133,
                    child: Padding(
                      padding: EdgeInsets.only(left: 26),
                      child: ClipRRect(
                        child: Image.network(image),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 31, bottom: 90),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 51, top: 152,right: 51),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
                    spreadRadius: -8,
                    blurRadius: 10,
                    offset: const Offset(1, 7),
                  )
                ]),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: valueColor == true ? purpleColor : lightWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13))),
                  onPressed: () {

                    FirebaseFirestore.instance.collection(email!).doc("requests").collection("requests").doc(email).set({"email": userEmail, "image":"https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png","name":userName });
                    //FirebaseFirestore.instance.collection(email!).doc("friends").collection("friends").add({"email": userEmail,"image" : userImage,"name":userName});
                    setState(() {
                      valueColor=false;
                    });
                  },
                  child: Text(
                      valueColor == true ? "Добавить в друзья" : "Заявка отправлена",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          color: valueColor == true ? lightWhiteColor : blackColor)),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top:240,left: 26,right: 22),
              child: SizedBox(
                width: 416,
                height: 60,
                child:Card(
                  color: lightWhiteColor,
                  elevation: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 310,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) =>
                                            UserDreams(name,email)));
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Мечты",
                                    style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 16,
                                        color: blackColor)),
                              )),
                        ),
                        Row(
                          children: [
                            Icon(Icons.arrow_forward_ios,size: 20,)
                          ],
                        )
                      ]),
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:315,left: 26,right: 22),
              child: SizedBox(
                width: 416,
                height: 60,
                child:Card(
                  color: lightWhiteColor,
                  elevation: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 310,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) =>
                                            UserListBuckets(name,email)));
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Бакет-листы",
                                    style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 16,
                                        color: blackColor)),
                              )),
                        ),
                        Row(
                          children: [
                            Icon(Icons.arrow_forward_ios,size: 20,)
                          ],
                        )
                      ]),
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
