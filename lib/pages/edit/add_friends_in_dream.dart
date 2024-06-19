
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
import '../other_people/friend.dart';
import 'dream_options.dart';

Map<String, bool> ListDreamItemValue = {};
List list=[];

String cardUserName = "";
String username = "";
var len;

class AddFriendsDream extends StatefulWidget {
  final name;
  AddFriendsDream(this.name);


  @override
  State<AddFriendsDream> createState() => _AddFriendsDream(name);
}

class _AddFriendsDream extends State<AddFriendsDream> {
  final name;
  _AddFriendsDream(this.name);

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
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) =>
                                    DreamProfile()));
                      },
                      icon: arrowImage,
                    ),
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
                  ],
                ))
          ]),
        ),
        body: BuildListFriends(name) ,
    );
  }

}


class BuildListFriends extends StatefulWidget {
  final name;
  BuildListFriends(this.name);

  @override
  State<BuildListFriends> createState() => _BuildListFriends(name);
}

class _BuildListFriends extends State<BuildListFriends> {
  final name;
  _BuildListFriends(this.name);



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
                            FirebaseFirestore.instance.collection(data["email"]).doc("dreams").collection("dream").doc(name).set({"name": name});
                            FirebaseFirestore.instance.collection(data["email"]).doc("dreams").collection("dreamValue").doc(name).set({"value": true});
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) =>
                                        DreamProfile()));
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
                            FirebaseFirestore.instance.collection(data["email"]).doc("dreams").collection("dream").doc(name).set({"name": name});
                            FirebaseFirestore.instance.collection(data["email"]).doc("dreams").collection("dreamValue").doc(name).set({"value": true});
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) =>
                                        DreamProfile()));
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
