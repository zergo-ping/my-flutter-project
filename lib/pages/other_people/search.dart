
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteit/design/images.dart';
import '../../design/colors.dart';
import '../../variables/variables.dart';
import 'other_people_main.dart';

Map<String, bool> ListDreamItemValue = {};

String cardUserName="";
String username = "";

class AddFriends1 extends StatefulWidget {
  const AddFriends1({super.key});


  @override
  State<AddFriends1> createState() => _DreamProfile();
}

class _DreamProfile extends State<AddFriends1> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void initState() {
    super.initState();
    initFirebase();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: whiteColor,
          title:  Stack(children: <Widget>[
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
                    Container(
                      decoration: BoxDecoration(boxShadow: []),
                      width: 298,
                      height: 48,
                      child: TextField(
                        onChanged: (val){
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
                  ],
                ))
          ])
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context,snapshots){
            if ((snapshots.connectionState == ConnectionState.waiting)) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder:(context,index){
                    var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;
                    if (cardUserName.isEmpty){
                      return ListTile(
                        title: Text(
                          data["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,),
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
                    if(data["name"].toString().contains(cardUserName)){
                      return ListTile(
                        title: Text(
                          data["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,),
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
          }
      ),
    );
  }
}



