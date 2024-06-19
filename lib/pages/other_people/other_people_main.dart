
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import 'package:noteit/pages/dream_profile/bucket_profile_page.dart';
import 'package:noteit/pages/dream_profile/dream_item.dart';
import 'package:noteit/pages/dream_profile/dream_profile_head.dart';
import 'package:noteit/pages/dream_profile/search_text.dart';
import 'package:noteit/pages/dream_profile/test.dart';
import 'package:noteit/pages/other_people/other_people_head.dart';
import 'package:noteit/pages/other_people/user_profile.dart';
import '../../design/colors.dart';
import '../../variables/variables.dart';
import '../dream_profile/dream_profile_page.dart';
import '../edit/bucket_edit.dart';
import '../edit/progress_bar.dart';
import 'add_friends.dart';
import 'friend.dart';
import 'invite_frends/invite_request.dart';

Map<String, bool> ListDreamItemValue = {};
List list=[];

String cardUserName = "";
String username = "";
var len;

class OtherPeopleProfile extends StatefulWidget {
  const OtherPeopleProfile({super.key});


  @override
  State<OtherPeopleProfile> createState() => _DreamProfile();
}

class _DreamProfile extends State<OtherPeopleProfile> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void initState() {
    super.initState();
    getDocumentData();
    initFirebase();
  }

  getDocumentData() async {
    CollectionReference _cat = FirebaseFirestore.instance.collection(userEmail!).doc("requests").collection("requests");
    QuerySnapshot querySnapshot = await _cat.get();
    final _docData = querySnapshot.docs.length;
    //ListNamesInBucket[index]=_docData.get("name").toString();
    len=_docData;
    print(_docData);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: whiteColor,
          title: Stack(children: <Widget>[
            Center(
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 25, right: 13)),
                    Container(
                      decoration: BoxDecoration(boxShadow: []),
                      width: 298,
                      height: 48,
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            cardUserName=val;
                          });
                        },
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
                                 AddFriends()));
                      },
                      icon: addFriendsImage,
                    )
                  ],
                ))
          ]),
        ),
        body: len == 0 ? BuildListFriends() : BuildListRequests(),
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
        IconButton(onPressed: () {
        }, icon: otherPeopleImage2),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: whiteColor,
                      title: const Text(
                        "Добавить мечту",
                        style: TextStyle(fontFamily: "Inter"),
                      ),
                      content: TextField(
                        onChanged: (String name) {
                          username = name;
                        },
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(170, 35),
                                backgroundColor: value == true ? whiteColor : purpleColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13))),
                            onPressed: () {
                              FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dream").doc(Timestamp.now().toString()).set({"name": username});
                              FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dreamValue").doc(username).set({"value": true});
                              username = "";
                              Navigator.of(context).pop();
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
        IconButton(onPressed: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                  const DreamProfile()));
        }, icon: myDreamsImage),
      ],
    );
  }
}



class BuildListRequests extends StatefulWidget{
  const BuildListRequests({super.key});

  @override
  State<BuildListRequests> createState() => _BuildListRequests();

}

class _BuildListRequests extends State<BuildListRequests>{
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(userEmail!).doc("requests").collection("requests").snapshots(),
            builder: (context, snapshots) {
              if ((snapshots.connectionState == ConnectionState.waiting)) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;
                      if (cardUserName.isEmpty) {
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
                                                pageBuilder:
                                                    (context, animation1, animation2) =>
                                                    InviteRequest(data["name"],"https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png",data["email"])));
                                      },
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Заявка в друзья",
                                            style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 16,
                                                color: blackColor)),
                                      )),
                                ),
                              ]),
                        );
                      }
                      return Container();
                    });
              }
            });
  }


}









class BuildListFriends extends StatefulWidget {
  const BuildListFriends({super.key});

  @override
  State<BuildListFriends> createState() => _BuildListFriends();
}

class _BuildListFriends extends State<BuildListFriends> {

  //getDocumentData (String username) async {
  //  DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dreamValue").doc(username);
  //  DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _cat.get();
  //  final _docData = querySnapshot.get("value");
  //  ListDreamItemValue[username]= _docData;
  //  print(ListDreamItemValue[username]);
  //}


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(userEmail!).doc("friends").collection("friends").snapshots(),
            builder: (context, snapshots) {
              if ((snapshots.connectionState == ConnectionState.waiting)) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;
                      if (cardUserName.isEmpty) {
                        return ListTile(
                          title: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                FriendProfile(data["name"],data["image"],data["email"])));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    data["name"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                          ),
                          subtitle: Text(
                            data["email"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data["image"]),
                          ),
                        );
                      }
                      if (data["name"].toString().startsWith(cardUserName.toLowerCase())) {
                        return ListTile(
                          title: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                FriendProfile(data["name"],data["image"],data["email"])));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    data["name"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                          ),
                          subtitle: Text(
                            data["email"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data["image"]),
                          ),
                        );
                      }
                      return Container();
                    });
              }
            });
  }
}
