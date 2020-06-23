import 'package:flutter/material.dart';

int primaryBlue = 0xff0070FF;
int primaryBlack = 0xff1c1c1c;
const double paddingLeft = 40.0;

BoxShadow containerBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  blurRadius: 5.0, // soften the shadow
  spreadRadius: 7.0, //extend the shadow
  offset: Offset(
    0.0, // Move to right 10  horizontally
    3, // Move to bottom 10 Vertically
  ),
);
