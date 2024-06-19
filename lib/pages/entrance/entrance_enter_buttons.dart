import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteit/pages/entrance/entrance_textfield.dart';
import '../../design/colors.dart';
import '../../design/images.dart';
import '../../variables/variables.dart';
import '../dream_profile/bucket_profile_page.dart';
import 'entrance_head.dart';
import 'entrance_register_buttons.dart';

class EntranceEnterButtons extends StatefulWidget {
  EntranceEnterButtons({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<EntranceEnterButtons> createState() => _EntranceButtonsState(emailController,passwordController);
}

class _EntranceButtonsState extends State<EntranceEnterButtons> {
  final emailController;
  final passwordController;

  _EntranceButtonsState(this.emailController,this.passwordController);

  void signUserIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    );
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
                                backgroundColor:
                                valueEntrance == true ? purpleColor : whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13))),
                            onPressed: () {
                              setState(() {
                                valueEntrance = true;
                              });
                            },
                            child: Text("Войти",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    color:
                                    valueEntrance == true ? whiteColor : blackColor)),
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
                                backgroundColor:
                                valueEntrance == true ? whiteColor : purpleColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13))),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) =>
                                          EntranceRegisterButtons()));
                              setState(() {
                                valueEntrance = false;
                              });
                            },
                            child: Text("Создать аккаунт",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    color:
                                    valueEntrance == true ? blackColor : whiteColor)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                    child:MyTextField(controller: emailController, hintText: 'E-mail', obscureText: false,) ,
                    padding: EdgeInsets.only(top: 45,right: 20,left: 20)
                ),
                Padding(
                    child:MyTextField(controller: passwordController, hintText: 'Введите пароль', obscureText: true,) ,
                    padding: EdgeInsets.only(top: 15)
                ),
                TextButton(onPressed: (){}, child: Text("Забыли пароль?",style: TextStyle(color: blackColor,fontFamily: "Inter",fontSize: 16),)),
                SizedBox(
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
                          backgroundColor:
                          valueEntrance == true ? purpleColor : whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                      onPressed: signUserIn,
                      child: Text("Войти",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 20,
                              color:
                              valueEntrance == true ? whiteColor : blackColor)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
