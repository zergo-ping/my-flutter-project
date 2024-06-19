
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import '../../design/colors.dart';
import '../../variables/variables.dart';
import '../edit/dream_options.dart';
import '../edit/progress_bar.dart';
import '../other_people/other_people_main.dart';

Map<String, bool> ListDreamItemValue = {};
List list=[];
int number1=0;
String username = "";

class DreamProfile extends StatefulWidget {
  const DreamProfile({super.key});


  @override
  State<DreamProfile> createState() => _DreamProfile();
}

class _DreamProfile extends State<DreamProfile> {
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
        IconButton(onPressed: () {
          if (number1 == 1){
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                    const OtherPeopleProfile()));
          }
          else{
            number1=1;

            FirebaseFirestore.instance.collection("users").add({"email":userEmail,"name":userName,"image":"https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png"});

            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                    const OtherPeopleProfile()));
          }
        }, icon:otherPeopleImage),
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
                                backgroundColor:
                                    value == true ? whiteColor : purpleColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13))),
                            onPressed: () {
                              FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dream").doc(username).set({"name": username});
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
        _SafeArea(context),
        buttons(),
        //Padding(padding: EdgeInsets.only(top:131,),child:search())
      ],
    );
  }

  @override
  Widget _SafeArea(BuildContext context) {
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
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const BucketProfile()));
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
  String name = user;
  bool valueDone = true;

  getDocumentData (String username) async {
    DocumentReference<Map<String, dynamic>> _cat = FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dreamValue").doc(username);
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _cat.get();
    final _docData = querySnapshot.get("value");
    ListDreamItemValue[username]= _docData;
    print(ListDreamItemValue[username]);
  }


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dream").snapshots(),
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
                                    setState(() {
                                      if(snapshot.data!.docs[index].exists){
                                        ListDreamItemValue[snapshot.data!.docs[index].get("name")] = ListDreamItemValue[snapshot.data!.docs[index].get("name")] == false;
                                        ListDreamItemValue[snapshot.data!.docs[index].get("name")] == false ? number++ : number--;
                                        FirebaseFirestore.instance.collection(userEmail!).doc("dreams").collection("dreamValue").doc(snapshot.data!.docs[index].get("name")).set({"value": ListDreamItemValue[snapshot.data!.docs[index].get("name")]});
                                      }
                                      progress = 0;
                                    });
                                    print(ListDreamItemValue[snapshot.data!.docs[index].get("name")]);
                                    getDocumentData(snapshot.data!.docs[index].get("name"));
                                  },
                                  icon: ListDreamItemValue[snapshot.data!.docs[index].get("name")] == true ? doneImage2 : doneImage),
                              IconButton(onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) =>
                                         DreamOptions(snapshot.data!.docs[index].get("name"),index)));


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
            }));
  }
}
