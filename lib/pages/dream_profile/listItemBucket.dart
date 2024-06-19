//
//
//import 'dart:async';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:noteit/pages/edit/progress_bar.dart';
//import '../../design/colors.dart';
//import '../../design/images.dart';
//import '../../variables/variables.dart';
//import '../edit/bucket_edit.dart';
//import '../edit/listItem.dart';
//
//List<ListItemBucket> ListBucketItems = [];
//Map<String,bool> ListBucketItemValue={};
//
//class ListItemBucket extends StatefulWidget {
//
//  String name="";
//  ListItemBucket(this.name);
//
//
//  @override
//  State<ListItemBucket> createState() => ListItemState(name);
//
//}
//
//class ListItemState extends State<ListItemBucket>{
//  ListItemState(this.name);
//  String name;
//  get array => List<ListItemBucket>;
//
//
//
//
//
//  @override
//  Widget build(BuildContext context){
//    return Card(
//      color: lightWhiteColor,
//      elevation: 0,
//      child: Row(
//          mainAxisAlignment:
//          MainAxisAlignment.spaceBetween,
//          children: [
//            Container(
//              height: 60,
//              color: lightWhiteColor,
//            ),
//            SizedBox(
//              width: 225,
//              child: TextButton(
//                  onPressed: () {
//                    print(name);
//                    Navigator.pushReplacement(context,PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>BucketEdit(name)));
//
//                  },
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                        textDirection:
//                        TextDirection.rtl,
//                        name,
//                        style: const TextStyle(
//                            fontFamily: "Inter",
//                            fontSize: 16,
//                            color: blackColor)),
//                  )
//              ),
//            ),
//            Row(
//              children: [
//                IconButton(
//                    onPressed: () {
//                      setState(() {
//                        ListValueInBucket[name] = ListValueInBucket[name]==false;
//                        print(number);
//                        ListValueInBucket[name]== false ? number++ : number--;
//                        progress=0;
//                      });
//                    },
//                    icon: ListValueInBucket[name] == false ? doneImage2 : doneImage),
//                IconButton(
//                    onPressed: () {}, icon: editImage)
//              ],
//            )
//          ]),
//    );;
//  }
//
//
//}
//








