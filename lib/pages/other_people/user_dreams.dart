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

int number=0;



class UserDreams extends StatefulWidget {
  String name;
  final email;
  UserDreams(this.name,this.email);
  @override
  _UserDreams createState() => _UserDreams(name,email);
}

class _UserDreams extends State<UserDreams> {

  String name;
  final email;
  _UserDreams(this.name,this.email);
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
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 100,
          leading: Container(
              padding: EdgeInsets.only(bottom: 50),
              child: IconButton(
                onPressed: () {
                  number=0;
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                           UserProfile(name,image,email)));
                },
                icon: arrowImage,
              )),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 50, right: 40),
                child: Text(name),
              ),
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
        body: Container(child: BuildList(name,email)),
    );
  }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class BuildList extends StatefulWidget {

  String name;
  final email;
  BuildList(this.name,this.email);

  @override
  State<BuildList> createState() => _BuildList(name,email);
}

class _BuildList extends State<BuildList> {

  String name;
  final email;
  _BuildList(this.name,this.email);

  //getDocumentData(String username) async {
  //  DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(email!).doc("buckets").collection("DreamsInBucket").doc(name);
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
            stream: FirebaseFirestore.instance.collection(email!).doc("dreams").collection("dream").snapshots(),
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
                                onPressed: () {},
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
                                  icon: ListDreamItemValue[snapshot.data!.docs[index].get("name")] == true ? doneImage2 : doneImage),
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

