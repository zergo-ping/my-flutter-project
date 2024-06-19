import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/dream_profile/dream_profile_head.dart';
import 'package:noteit/pages/edit/bucket_edit.dart';
import '../../design/colors.dart';
import '../../variables/variables.dart';
import '../edit/add_friends_in_bucket.dart';
import '../edit/bucket_options.dart';
import '../edit/progress_bar.dart';
import 'dream_profile_page.dart';
import 'listItemBucket.dart';

Map<String, bool> ListBucketItemValue = {};

class BucketProfile extends StatefulWidget {
  const BucketProfile({super.key});

  @override
  State<BucketProfile> createState() => _BucketProfile();
}

class _BucketProfile extends State<BucketProfile> {
  String timeName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: const DreamProfileHead(),
        ),
        body: Container(child: DreamtList()),
        bottomNavigationBar: SizedBox(
          height: 120,
          child: _footer(),
        ));
  }

  @override
  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: () {}, icon: otherPeopleImage),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: whiteColor,
                      title: const Text(
                        "Добавить Бакет-лист",
                        style: TextStyle(fontFamily: "Inter"),
                      ),
                      content: TextField(
                        onChanged: (String name) {
                          timeName = name;
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
                                FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("bucketNames").doc(timeName).set({"name": timeName});
                                FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("bucketValue").doc(timeName).set({"value": false});
                              });
                              Navigator.of(context).pop();
                              timeName = "";
                            },
                            child: Text("Добавить",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    color: value == true
                                        ? blackColor
                                        : whiteColor)),
                          ),
                        )
                      ],
                    );
                  });
            },
            icon: plusMainImage),
        IconButton(onPressed: () {}, icon: myDreamsImage),
      ],
    );
  }
}

class DreamtList extends StatelessWidget {
  const DreamtList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _HomeScreen(context),
        buttons(),
      ],
    );
  }

  @override
  Widget _HomeScreen(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: whiteColor,
                margin: const EdgeInsets.only(top: 0),
                height: MediaQuery.of(context).size.height * 0.2,
                child: const Align(
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(bottom: 200),
                color: whiteColor,
                child: BuildList(),
              )),
            ],
          ),
        )),
      ),
    );
  }
}

class buttons extends StatefulWidget {
  const buttons({super.key});

  @override
  State<buttons> createState() => _HomeState();
}

class _HomeState extends State<buttons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 52, right: 40)),
            Container(
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
                    minimumSize: const Size(170, 35),
                    backgroundColor: value == true ? purpleColor : whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              DreamProfile()));
                  setState(() {
                    value = true;
                  });
                },
                child: Text("Мечты",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: value == true ? whiteColor : blackColor)),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 52, right: 40)),
            Container(
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
                    minimumSize: const Size(170, 35),
                    backgroundColor: value == true ? whiteColor : purpleColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                onPressed: () {
                  setState(() {
                    value = false;
                  });
                },
                child: Text("Бакет-листы",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: value == true ? blackColor : whiteColor)),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class BuildList extends StatefulWidget {
  const BuildList({super.key});

  @override
  State<BuildList> createState() => _BuildList();
}

class _BuildList extends State<BuildList> {
  getDocumentData(String username) async {
    DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("bucketValue").doc(username);
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _cat.get();
    final _docData = querySnapshot.get("value");
    ListBucketItemValue[username] = _docData;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("bucketNames").snapshots(),
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
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
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
                                      if (snapshot.data!.docs[index].exists) {
                                        ListBucketItemValue[snapshot.data!.docs[index].get("name")] = ListBucketItemValue[snapshot.data!.docs[index].get("name")] == false;
                                        FirebaseFirestore.instance.collection(userEmail!).doc("buckets").collection("bucketValue").doc(snapshot.data!.docs[index].get("name")).set({"value": ListBucketItemValue[snapshot.data!.docs[index].get("name")]
                                        });
                                        progress = 0;
                                      }
                                    });
                                  },
                                  icon: ListBucketItemValue[snapshot.data!.docs[index].get("name")] == false ? doneImage2 : doneImage),
                              IconButton(onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) =>
                                            BucketOptions(snapshot.data!.docs[index].get("name"),index)));
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
                itemCount: snapshot.data!.docs.length,
              );
            }));
  }
}
