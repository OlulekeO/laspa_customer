import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/ussd_code_generation.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';





class cardPayment_Parking extends StatefulWidget {

  // String url = 'http://dev.prananet.io/LaspaApp/Payment/cardpayment?i=';
  final url;
  String customerEmail;
  String password;
  String parkingSpotID;


  cardPayment_Parking(this.url,this.customerEmail,this.password,this.parkingSpotID);

  // const cardPayment({Key? key}) : super(key: key);

  @override
  _cardPayment_ParkingState createState() => _cardPayment_ParkingState(this.url,this.customerEmail,this.password,this.parkingSpotID);
}

class _cardPayment_ParkingState extends State<cardPayment_Parking> {

  var _url;
  String customerEmail;
  String password;
  String parkingSpotID;

  final _key = UniqueKey();

  _cardPayment_ParkingState(this._url,this.customerEmail,this.password,this.parkingSpotID);



  String location = 'Shomolu';
  String platenumber = '';
  //String customerEmail = '';
 // String password = '';
  String parkingAmount= '';
  String parkingSpotName = '';
  String cityName = '';
  String parkingLocationName = '';
  // String ParkingSpotID = '';
  String parkingHour = '';
  // String ParkingAreaID = '';


  // Future getEmail() async { setState((){});
  //   setState((){});
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     customerEmail = preferences.getString('email');
  //     password = preferences.getString('password');
  //     parkingAmount = preferences.getString('parkingAmount');
  //     cityName = preferences.getString('cityName');
  //     parkingLocationName = preferences.getString('parkingLocationName');
  //     parkingSpotName = preferences.getString('parkingSpotName');
  //     ParkingSpotID = preferences.getString('ParkingSpotID');
  //     // ParkingAreaID = preferences.getString('pid');
  //
  //
  //     // print (cityName);
  //     // print (parkingLocationName);
  //     // print (parkingSpotName);
  //   });
  //   setState((){});
  // }


  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((_) => getEmail());
    super.initState();
    // getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [

            Expanded(
                child: WebView(

                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url+cityName+'&Email='+customerEmail+'&ParkingSpotID='+parkingSpotID+'&password='+password))
          ],
        ));
  }
}
