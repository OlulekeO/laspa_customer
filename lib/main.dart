// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/splash.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Welcome',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: splash_Screen()
      ));
}