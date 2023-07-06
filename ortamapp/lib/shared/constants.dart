import 'dart:ui';
import 'package:flutter/material.dart';
String hexColor = "#005CDF";
Color backgColor = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
String hexColor2 = "#005CDF";
Color backgColor2 = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xD1E4FF);
class Constants {

  static String appId = "1:287385853570:android:e7a5e1306436ae2c1d5e9b";
  static String apiKey = "AIzaSyDfB7lkK2GuyTckrOyjdLyzCTQIO7V0ByQ";
  static String messagingSenderId = "287385853570";
  static String projectId = "ortamapp-1777b";
  final primaryColor = backgColor;
  final secondaryColor = backgColor2;
}
