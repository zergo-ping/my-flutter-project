
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../design/colors.dart';
import '../dream_profile/listItemBucket.dart';
import 'bucket_edit.dart';


double progress = 0;



class ProgressBar extends StatefulWidget {


  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {

  iterator(){
    ListValueInBucket.forEach((key, value) {
      if(value==true){
        number++;
      }
      else{
        number--;
      }
    });

  }



  void start() {
    new Timer.periodic(
      Duration(seconds: 0),
          (Timer timer) => setState(
            () {
          if (progress == 1) {
            timer.cancel();
          } else {
            progress += 1;
          }
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    start();
    return SizedBox(
      width: 280,
      height: 36,
      child: LinearProgressIndicator(
        color:purpleColor ,
        backgroundColor: lightWhiteColor,
        borderRadius:BorderRadius.circular(26) ,
        value: ListValueInBucket.length == 0 ? 0 : number/ListValueInBucket.length
      ),
    );
  }
}

