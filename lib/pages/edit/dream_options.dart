import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/dream_profile/dream_profile_head.dart';
import 'package:noteit/pages/edit/progress_bar.dart';
import 'package:noteit/pages/other_people/user_profile.dart';
import 'package:noteit/variables/variables.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../design/colors.dart';
import '../dream_profile/bucket_profile_page.dart';
import '../dream_profile/dream_profile_page.dart';
import '../dream_profile/listItemBucket.dart';
import 'add_friends_in_dream.dart';

int number=0;



class DreamOptions extends StatefulWidget {
  String name;
  final index;
  DreamOptions(this.name,this.index);
  @override
  _DreamOptions createState() => _DreamOptions(name,index);
}

class _DreamOptions extends State<DreamOptions> {

  String name;
  final index;
  _DreamOptions(this.name,this.index);
  String timeName="";
  String image="https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[
          headBucketEdit(context),
        ],
      ),
    );
  }



  @override
  Widget headBucketEdit(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        toolbarHeight: 100,
        leading: Container(
            padding: EdgeInsets.only(bottom: 1),
            child: IconButton(
              onPressed: () {
                number=0;
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            DreamProfile()));
              },
              icon: crossImage,
            )),
        title: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, right: 40),
              child: Text("Изменить мечту"),
            ),
            Container(
              padding: EdgeInsets.only(left: 200),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 35),
                    backgroundColor: purpleColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DreamProfile()));
                },
                child: Text("Добавить",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: whiteColor)),
              ),
            )
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(29),
                bottomRight: Radius.circular(29)),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30,left: 37),
            child:Text("Обложка мечты") ,
          ),
          Container(
            padding: EdgeInsets.only(top: 60,left: 37),
            child: SizedBox(
              width: 140,
              height: 133,
              child: ColoredBox(
                color: lightWhiteColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 220,left: 37),
            child:Stack(
              children: [
                Text("Название мечты:"),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                  child:Text(name,style: TextStyle(fontSize: 16),),
                ),
              ],
            ) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 290,left: 37),
            child:Stack(
              children: [
                Text("Описание мечты:"),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:TextField(
                    decoration:InputDecoration(
                      border: InputBorder.none,
                      hintText: "Расскажите больше о своей мечте",
                      hintStyle:TextStyle(fontSize: 16,fontFamily: "Inter")
                    ) ,
                  ),
                ),
              ],
            ) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 350,left: 37),
            child:Stack(
              children: [
                Text("Соавторы"),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child:IconButton(onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                AddFriendsDream(name)));
                  }, icon: addAuthorsImage,iconSize: 20,),
                ),
              ],
            ) ,
          ),
          Container(
            padding: EdgeInsets.only(top: 430,left: 37),
            child:Stack(
              children: [
                TextButton(onPressed: () {
                  FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dream").doc(name).delete();
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DreamProfile()));
                }, child: Text("Удалить мечту",style: TextStyle(color: blackColor),),),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child:Text("Навсегда удалить эту метчу.Это действие невозмонжо отменить ",style: TextStyle(fontSize: 16,color: Colors.grey,),maxLines: 2,),
                ),
              ],
            ) ,
          ),
          Padding(
            padding: EdgeInsets.only(top: 550,left: 37),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 65),
                  backgroundColor: purpleColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))),
              onPressed: () {
                FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dream").doc(name).delete();
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            DreamProfile()));

              },
              child: Text("Мечта сбылась!",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      color: whiteColor)),
            ),
          )
        ],
      ),
    );
  }

}



