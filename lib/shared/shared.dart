import 'package:flutter/material.dart';

var textInputDecoration =InputDecoration(
  // fillColor: Colors.green[100],
  // filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide( color: Colors.black)

    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide( color: Colors.black)
    )
);
// Colors that we use in our app
const kPrimaryColor = Color(0xffffcc00);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;