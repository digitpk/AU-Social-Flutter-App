import 'package:flutter/material.dart';

int primaryBlue = 0xff0070FF;
int primaryBlack = 0xff1c1c1c;
const double paddingLeft = 40.0;
const double paddingInDetailPage = 15.0;

const List<String> departments = [
  'College Culturals',
  'Bio-Technology',
  'CECRI',
  'Ceramic Technology',
  'Chemical Engineering',
  'Leather Technology',
  'Rubber and Plastic Technology',
  'Textile Technology',
  'Applied Science Technology',
  'Disaster mitigation and management',
  'Environmental Studies',
  'Water Resources',
  'Civil Engineering',
  'Soil Mechanics and Foundation Management',
  'Transportation Management',
  'Ocean Management',
  'Remote Sensing',
  'Structural Engineering Division',
  'AeroSpace Engineering',
  'Automobile Engineering',
  'Industrial Engineering',
  'Manufacturing Engineering',
  'Mechanical Engineering',
  'Mining Engineering',
  'Printing Technology',
  'Energy Studies',
  'Manufacturing System Management',
  'Production Technology',
  'Electrical and Electronics Engineering',
  'Instrumentation Engineering',
  'Medical Electronics',
  'Computer Science and Engineering',
  'Computer Technology',
  'Electronics and Communication Engineering',
  'Electronics Engineering',
  'Information Science and Technology',
  'Information Technology',
  'Management Studies',
  'Chemistry',
  'English',
  'Geology',
  'Mathematics',
  'Media Sciences',
  'Medical Physics',
  'Physics',
  'Architecture',
  'Planning',
];

BoxShadow containerBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  blurRadius: 5.0, // soften the shadow
  spreadRadius: 7.0, //extend the shadow
  offset: Offset(
    0.0, // Move to right 10  horizontally
    3, // Move to bottom 10 Vertically
  ),
);
