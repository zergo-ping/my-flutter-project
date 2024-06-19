

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var UserFirstName="";
var userEmail= FirebaseAuth.instance.currentUser!.email;
var userName=FirebaseAuth.instance.currentUser!.displayName;
var userImage=FirebaseAuth.instance.currentUser!.updatePhotoURL("https://cs14.pikabu.ru/avatars/3998/x3998528-1796862594.png");
bool valueEntrance=true;
bool value=true;
String bucketName="";
String buketNameFor="";
String user= "";
List<Card> listDream = [];  
bool people=false;
String usernameForList="";