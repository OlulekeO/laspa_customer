import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/parking_cardpayment.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/parking_fee_payments/ussd_pay.dart';
import 'package:laspa_customer/parking_fee_payments/wallet_pay.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final _links = 'https://app.prananet.io/LaspaApp/Payment/Appcardpayment?i=';

//+'&Email='+customerEmail+'&ParkingSpotID='+ParkingSpotID+'&password='+password
// String cityName='';

class payment_options extends StatefulWidget {
  const payment_options({Key? key, required String value}) : super(key: key);

  @override
  _payment_optionsState createState() => _payment_optionsState();
}

class _payment_optionsState extends State<payment_options> {



  var amount= '';

  String platenumber = '';
  String customerEmail = '';
  String password = '';
  String parkingAmount= '';
  String parkingSpotName = '';
  String cityName = '';
  String parkingLocationName = '';
  String ParkingSpotID = '';
  String parkingHour = '';
  String ParkingAreaID = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      password = preferences.getString('password');
      parkingAmount = preferences.getString('parkingAmount');
      cityName = preferences.getString('cityName');
      parkingLocationName = preferences.getString('parkingLocationName');
      parkingSpotName = preferences.getString('parkingSpotName');
      ParkingSpotID = preferences.getString('ParkingSpotID');
      ParkingAreaID = preferences.getString('pid');

    });
  }


  @override
  void initState() {
    super.initState();
    getEmail();
  }


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
          padding: const EdgeInsets.all(30.0),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
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
                    child: const Text(
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

                      _handleURLButtonPress(context, _links,ParkingAreaID,customerEmail,password,ParkingSpotID);



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
                    child: const Text(
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
void _handleURLButtonPress(BuildContext context, String url, String ParkingAreaID,String customerEmail,String password,String ParkingSpotID) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => cardPayment_Parking(url+ParkingAreaID,customerEmail,password,ParkingSpotID)));
}


