import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/parking_ussd_code_generate.dart';
import 'package:laspa_customer/PaymentMethod/ussd_code_generation.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String parkingLocationName = '';



class fee_payment_wallet extends StatefulWidget {
  const fee_payment_wallet({Key? key}) : super(key: key);

  @override
  _fee_payment_walletState createState() => _fee_payment_walletState();
}

class _fee_payment_walletState extends State<fee_payment_wallet> {


  List<String> property = [
    'GTB', 'herit', 'WEMA','UNION'

  ];


  List<String> hours = [
    'No of Hours', '1', '2','3','4'

  ];

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String dropdownStr =  'GTB';
  var amount= '';
  String dropdownStrHours = 'No of Hours';

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


  customerUssdPayment() async {
    HttpClient client =  HttpClient();
    // client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/customer_wallet_parkpayment";



    if (dropdownStrHours == 'No of Hours'){

      String message = "Choose Duration!!!";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => fee_payment_wallet()));

                },
              ),
            ],
          );
        },
      );

    }else{

      final response = await http.post(url, body: {
        "amount": parkingAmount,
        "password": password,
        "customerEmail": customerEmail,
        "ParkingSpotID": ParkingSpotID,
        "platenumber": platenumber,
        "parkingHour": dropdownStrHours,
        "ParkingAreaID": ParkingAreaID,

      });
      String responseData = json.encode(response.body);
      String message = json.decode(responseData);
      print(message);

      // print(dropdownStrHours);
      // print(ParkingAreaID);

      if(message.contains("Parking fee payment successful")){

        setState(() {
        });
        String message = "Payment Successful!!!";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => MyApp()));

                  },
                ),
              ],
            );
          },
        );

      }
      else{
        setState(() {
        });
        String message = "Insufficient Fund!!";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

    }




  }








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

        child: Flexible(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SingleChildScrollView(
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
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // even space distribution
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Pay from Wallet",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 40,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('City Name',  style: TextStyle(fontSize: 16)),
                          Text(cityName),


                        ],



                      ),
                      const SizedBox(
                        height: 10,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('Parking Area',  style: TextStyle(fontSize: 16)),
                          Text(parkingLocationName),


                        ],



                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('Parking Spot',  style: TextStyle(fontSize: 16)),
                          Text(parkingSpotName),


                        ],



                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text('Amount/Hour',  style: TextStyle(fontSize: 16)),
                          Text("NGN " + parkingAmount),


                        ],



                      ),
                      // Text(parkingAmount),

                      const SizedBox(
                        height: 10,
                      ),


                      // DropdownButton(
                      //   focusColor: Colors.redAccent,
                      //   hint: Text("Choose Bank"),
                      //   isExpanded: true,
                      //   value: dropdownStr,
                      //   icon: Icon(Icons.arrow_drop_down),
                      //   iconEnabledColor: Colors.redAccent,
                      //   iconSize: 30,
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownStr = newValue!;
                      //     });
                      //   },
                      //   items: property
                      //       .map<DropdownMenuItem<String>> ((String value){
                      //     return DropdownMenuItem<String> (
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),



                      TextField(
                        onChanged :(val){

                          setState(() => platenumber = val);
                        },
                        decoration: InputDecoration(
                          // icon: Icon(Icons.account_circle),
                          labelText: 'Plate Number',
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),


                      DropdownButton(
                        focusColor: Colors.redAccent,
                        hint: Text("Choose duration"),
                        isExpanded: true,
                        value: dropdownStrHours,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.redAccent,
                        iconSize: 30,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownStrHours = newValue!;
                          });
                        },
                        items: hours
                            .map<DropdownMenuItem<String>> ((String value){
                          return DropdownMenuItem<String> (
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {

                            if(_formKey.currentState!.validate()){
                              setState(() => loading = true);

                              customerUssdPayment();
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context) => code_generation()));
                          },
                          color: Color(0xffffcc00),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: (loading)
                              ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1.5,
                              )): const Text(
                            "Pay now",
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
          ),
        ),

      ),
    );
  }
}
