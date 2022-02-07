import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/parking_fee_payments/ussd_pay.dart';
import 'package:laspa_customer/parking_fee_payments/wallet_pay.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class payment_options_topup extends StatefulWidget {
  const payment_options_topup({Key? key, required String value}) : super(key: key);

  @override
  _payment_options_topupState createState() => _payment_options_topupState();
}

class _payment_options_topupState extends State<payment_options_topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffB6B6B6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.grey.shade700,
              size: 30,
            ),
          )
        ],

      ),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),


            // we will give media query height
            // double.infinity make it big as my parent allows
            // while MediaQuery make it big as per the screen

            width: double.infinity,
            height: MediaQuery.of(context).size.height/3.0,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 40,
                    onPressed: () async {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => fee_payment_ussd()));
                    },
                    color: Color(0xffffcc00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Pay with USSD",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 40,
                    onPressed: () async {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => fee_payment_ussd()));
                    },
                    color: Color(0xffffcc00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Pay with Card",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 40,
                    onPressed: () async {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => fee_payment_wallet()));
                    },
                    color: Color(0xffffcc00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Pay with Wallet",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
