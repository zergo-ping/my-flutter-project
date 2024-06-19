import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/dream_profile/dream_profile_head.dart';
import 'package:noteit/pages/edit/progress_bar.dart';
import 'package:noteit/pages/other_people/user_list_buckets.dart';
import 'package:noteit/pages/other_people/user_profile.dart';
import 'package:noteit/variables/variables.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../design/colors.dart';
import '../dream_profile/bucket_profile_page.dart';
import '../dream_profile/dream_profile_page.dart';
import '../dream_profile/listItemBucket.dart';
import '../edit/bucket_edit.dart';

int number=0;
int num2=0;

double percent=0;

Map<String,int>  ListNumbers={};





class UserBucket extends StatefulWidget {
  String name;
  final nameOfBucket;
  final email;
  UserBucket(this.name,this.email,this.nameOfBucket);
  @override
  _UserBucket createState() => _UserBucket(name,email,nameOfBucket);
}

class _UserBucket extends State<UserBucket> {

  String name;
  final nameOfBucket;
  final email;
  _UserBucket(this.name,this.email,this.nameOfBucket);
  String timeName="";


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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 200,
          leading: Container(
              padding: EdgeInsets.only(bottom: 150),
              child: IconButton(
                onPressed: () {
                  number=0;
                  Navigator.pop(context);
                },
                icon: arrowImage,
              )),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 30, right: 50),
                child: Text(name)
              ),
              Container(
                padding: EdgeInsets.only(right: 50,bottom: 50),
                child: Text(nameOfBucket)
              ),
              Container(
                padding: EdgeInsets.only(right: 50,bottom: 1),
                child:ProgressBar(),
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
        body: Container(child: BuildList(name,email,nameOfBucket)),
        );
  }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class BuildList extends StatefulWidget {

  String name;
  final nameOfBucket;
  final email;
  BuildList(this.name,this.email,this.nameOfBucket);

  @override
  State<BuildList> createState() => _BuildList(name,email,nameOfBucket);
}

class _BuildList extends State<BuildList> {

  String name;
  final nameOfBucket;
  final email;
  _BuildList(this.name,this.email,this.nameOfBucket);

  String image="https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png";

  //getDocumentData(String username) async {
  //  DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name);
  //  DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _cat.get();
  //  final _docData = querySnapshot.get("value");
  //  ListValueInBucket[username] = _docData;
  //  print(ListValueInBucket[username]);
  //}



  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(email!).doc("buckets").collection("DreamsInBucket").doc(nameOfBucket).collection("name").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text("нет записей");
              return ListView.separated(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: lightWhiteColor,
                    elevation: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            color: lightWhiteColor,
                          ),
                          SizedBox(
                            width: 225,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation1, animation2) =>
                                              UserProfile(name, image, email)));
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      snapshot.data!.docs[index].get("name"),
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
                                    //setState(() {
                                    //  if(snapshot.data!.docs[index].exists) {
                                    //    ListValueInBucket[snapshot.data!.docs[index].get("name")] = ListValueInBucket[snapshot.data!.docs[index].get("name")] == false;
                                    //    ListValueInBucket[snapshot.data!.docs[index].get("name")] == false ? number++ : number--;
                                    //    FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name).collection("value").doc(snapshot.data!.docs[index].get("name")).set({"value":ListValueInBucket[snapshot.data!.docs[index].get("name")]});
                                    //  }
                                    //});
                                    //ListNumbers[snapshot.data!.docs[index].get("name")]=number;
                                    //num2=ListValueInBucket.length;
                                    //print(number);
                                    //print(num2);
                                  },
                                  icon: ListValueInBucket[snapshot.data!.docs[index].get("name")] ==  false ? doneImage2 : doneImage),
                              IconButton(onPressed: () {}, icon: editImage)
                            ],
                          )
                        ]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    color: whiteColor,
                    height: 5,
                  );
                },
                itemCount: snapshot.data!.docs.length ,
              );
            })
    );
  }
}

