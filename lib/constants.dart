import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants{

  static TextStyle whiteBold22 = new TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 22.0,
    color: Colors.white
  );

  static TextStyle drkOrange20 = new TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: Colors.orange.shade900
  );

  static TextStyle drkBlue14 = new TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: Colors.blue.shade900
  );

  static TextStyle lightBlue14Thin = new TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
      color: Colors.blue.shade200
  );

  static TextStyle drkBlue16 = new TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: Colors.blue.shade900
  );

  static TextStyle error14 = new TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Colors.red.shade900
  );

  static TextStyle oldPrice = new TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
      color: Colors.black54,
    decoration: TextDecoration.lineThrough
  );

  static TextStyle price = new TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: Colors.red,
  );

  static TextStyle seeAll = new TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: Colors.blue.shade900,
  );
}