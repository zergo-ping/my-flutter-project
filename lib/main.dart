import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteit/pages/dream_profile/bucket_profile_page.dart';
import 'package:noteit/pages/dream_profile/dream_profile_page.dart';
import 'package:noteit/pages/edit/bucket_edit.dart';
import 'package:noteit/pages/entrance/auth_page.dart';
import 'package:noteit/pages/entrance/entrance_enter_buttons.dart';
import 'firebase_options.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'sg',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home:  AuthPage(),
      routes: {
        "/DreamProfile":(context)=>DreamProfile(),
        "/BucketProfile":(context)=>BucketProfile(),
        "/Entrance":(context)=>EntranceEnterButtons()

      },
    );
  }
}
