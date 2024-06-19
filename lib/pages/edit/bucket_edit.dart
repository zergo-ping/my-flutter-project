import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/dream_profile/dream_profile_head.dart';
import 'package:noteit/pages/edit/add_friends_in_bucket.dart';
import 'package:noteit/pages/edit/progress_bar.dart';
import 'package:noteit/variables/variables.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../design/colors.dart';
import '../dream_profile/bucket_profile_page.dart';
import '../dream_profile/dream_profile_page.dart';
import '../dream_profile/listItemBucket.dart';

int number=0;
int num2=0;

double percent=0;

Map<String,int>  ListNumbers={};


Map<String,bool> ListValueInBucket={};



class BucketEdit extends StatefulWidget {
  String name;
  BucketEdit(this.name);
  @override
  _BucketEdit createState() => _BucketEdit(name);
}

class _BucketEdit extends State<BucketEdit> {

  String name;
  _BucketEdit(this.name);
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
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const BucketProfile()));
                },
                icon: arrowImage,
              )),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 110, right: 50),
                child: Text(name),
              ),
              ProgressBar()
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
        body: Container(child: BuildList(name)),
        bottomNavigationBar: SizedBox(
          height: 120,
          child: _footer(),
        ));
  }

  @override
  Widget _footer() {
    return Center(
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: whiteColor,
                  title: const Text(
                    "Добавить Мечту",
                    style: TextStyle(fontFamily: "Inter"),
                  ),
                  content: TextField(
                    onChanged: (String name) {
                      timeName=name;
                    },
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(170, 35),
                            backgroundColor:
                            value == true ? whiteColor : purpleColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13))),
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name).collection("name").doc(Timestamp.now().toString()).set({"name": timeName});
                            FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name).collection("value").doc(timeName).set({"value": true});
                            if(friendemail.length > 0){
                              FirebaseFirestore.instance.collection(friendemail).doc("buckets").collection("DreamsInBucket").doc(name).collection("name").doc(Timestamp.now().toString()).set({"name": timeName});
                              FirebaseFirestore.instance.collection(friendemail).doc("buckets").collection("DreamsInBucket").doc(name).collection("value").doc(timeName).set({"value": true});
                            }
                            //ListValueInBucket[timeName]=true;
                            //ListElementsInBucket.add(ListItemBucket(timeName));

                          });
                          Navigator.of(context).pop();
                          timeName="";
                        },
                        child: Text("Добавить",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                color:
                                value == true ? blackColor : whiteColor)),
                      ),
                    )
                  ],
                );
              });
        },
        icon: plusMainImage,
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class BuildList extends StatefulWidget {

  String name;
  BuildList(this.name);

  @override
  State<BuildList> createState() => _BuildList(name);
}

class _BuildList extends State<BuildList> {

  String name;
  _BuildList(this.name);

  getDocumentData(String username) async {
    DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name);
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _cat.get();
    final _docData = querySnapshot.get("value");
    ListValueInBucket[username] = _docData;
    print(ListValueInBucket[username]);
  }



  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name).collection("name").snapshots(),
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
                                            BucketEdit(snapshot.data!.docs[index].get("name"))));
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
                                  setState(() {
                                    if(snapshot.data!.docs[index].exists) {
                                      ListValueInBucket[snapshot.data!.docs[index].get("name")] = ListValueInBucket[snapshot.data!.docs[index].get("name")] == false;
                                      ListValueInBucket[snapshot.data!.docs[index].get("name")] == false ? number++ : number--;
                                      FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("DreamsInBucket").doc(name).collection("value").doc(snapshot.data!.docs[index].get("name")).set({"value":ListValueInBucket[snapshot.data!.docs[index].get("name")]});
                                    }
                                  });
                                  ListNumbers[snapshot.data!.docs[index].get("name")]=number;
                                  num2=ListValueInBucket.length;
                                  print(number);
                                  print(num2);
                                },
                                icon: ListValueInBucket[snapshot.data!.docs[index].get("name")] ==  false ? doneImage2 : doneImage),
                            IconButton(onPressed: () {
                            }, icon: editImage)
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

