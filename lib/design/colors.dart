import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:gradients/gradients.dart';

const Color purpleColor = Color(0xFFC25DFF);

const Color whiteColor = Color(0xFFF5F5F5);

const Color deepPurpleColor = Color(0xFF8020BB);

const Color blackColor = Color(0xFF1D1D1D);

const Color lightWhiteColor = Color(0xFFECEBF3);

const Color gradient1 = Color(0xFFDADADA);

const Color gradient2 = Color(0xFFFFFEF6);

const Color hintColor = Color(0xFF6A6868);

final gradient = LinearGradientPainter(stops:[0.1,1],begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [gradient1, gradient2], colorSpace: ColorSpace.rgb);
