import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../design/colors.dart';
import '../../design/images.dart';
import '../../variables/variables.dart';
import '../dream_profile/bucket_profile_page.dart';
import 'auth_page.dart';
import 'entrance_enter_buttons.dart';
import 'entrance_head.dart';
import 'entrance_textfield.dart';


class EntranceRegisterButtons extends StatefulWidget {
  EntranceRegisterButtons({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final name = TextEditingController();

  @override
  State<EntranceRegisterButtons> createState() => _EntranceRegisterButtonsState(
      emailController, passwordController, name, confirmPasswordController);
}

class _EntranceRegisterButtonsState extends State<EntranceRegisterButtons> {
  final emailController;
  final passwordController;
  final confirmPasswordController;
  final name;

  _EntranceRegisterButtonsState(this.emailController, this.passwordController,
      this.name, this.confirmPasswordController);

  void signUserUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );



        await FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
          }
        });

        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder:
                    (context, animation1, animation2) =>
                    AuthPage()));
      } else {
        print("Пароли не совпадают!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const EntranceHead(),
          backgroundColor: whiteColor,
          toolbarHeight: 125,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(top: 52, right: 40)),
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
                                  backgroundColor: valueEntrance == true
                                      ? purpleColor
                                      : whiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                EntranceEnterButtons()));
                                setState(() {
                                  valueEntrance = true;
                                });
                              },
                              child: Text("Войти",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      color: valueEntrance == true
                                          ? whiteColor
                                          : blackColor)),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(top: 52, right: 40)),
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
                                  backgroundColor: valueEntrance == true
                                      ? whiteColor
                                      : purpleColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              onPressed: () {
                                setState(() {
                                  valueEntrance = false;
                                });
                              },
                              child: Text("Создать аккаунт",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      color: valueEntrance == true
                                          ? blackColor
                                          : whiteColor)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                      child: MyTextField(
                        controller: name,
                        hintText: 'Введите имя',
                        obscureText: false,
                      ),
                      padding: EdgeInsets.only(top: 45, right: 20, left: 20)),
                  Padding(
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'E-mail',
                        obscureText: false,
                      ),
                      padding: EdgeInsets.only(top: 15)),
                  Padding(
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Придумайте пароль',
                        obscureText: true,
                      ),
                      padding: EdgeInsets.only(top: 15)),
                  Padding(
                      child: MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Введите пароль еще раз',
                        obscureText: true,
                      ),
                      padding: EdgeInsets.only(top: 15)),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: 362,
                      height: 48,
                      child: Container(
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
                              backgroundColor: purpleColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13))),
                          onPressed: signUserUp,
                          child: Text("Создать аккаунт",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 20,
                                  color: whiteColor)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
