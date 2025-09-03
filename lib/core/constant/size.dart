import 'package:flutter/material.dart';

class Screensize {
  static late double width ;
  static late double height ;

  static void init (context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}