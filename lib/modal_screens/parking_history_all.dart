import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/model/customer_parking_transactions_all.dart';
import 'package:laspa_customer/model/parking_locations.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class parkingHistoryAll extends StatefulWidget {
  const parkingHistoryAll({Key? key}) : super(key: key);

  @override
  _parkingHistoryAllState createState() => _parkingHistoryAllState();
}

class _parkingHistoryAllState extends State<parkingHistoryAll> {


  String customerEmail = '';
  String password = '';
  String customerPhone = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      password = preferences.getString('password');
      customerEmail = preferences.getString('email');
      customerPhone = preferences.getString('phone');
    });
  }

  Future<List<Parking>> customerParking() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_parking_transactionsAll";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password":password,
      "Action": '1',
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Parking> parkings = [];
    for (var singleUser in responseData) {
      Parking parking = Parking(
        ParkingID: singleUser["ParkingID"],
        ContactID: singleUser["ContactID"],
        Amount: singleUser["Amount"],
        PlateNumber: singleUser["PlateNumber"],
        ParkingTime: singleUser["ParkingTime"],
        ParkingHour: singleUser["ParkingHour"],
        Parkingstatus: singleUser["Parkingstatus"],
        ParkingAreaID: singleUser["ParkingAreaID"],
        ParkingSpotID: singleUser["ParkingSpotID"],
        ParkingAreaName: singleUser["ParkingAreaName"],
        ExpiringTime: singleUser["ExpiringTime"],
        channel: singleUser["channel"],
        Location: singleUser["Location"],
        ParkingSpotName: singleUser["ParkingSpotName"],

        qrcode: "https://app.prananet.io/LaspaApp/Qrcode/QRImage.png",

      );

      //Adding user to the list.
      parkings.add(parking);

    }
    return parkings;

  }







  @override


  void initState() {
    super.initState();
    // getEmail();
    // customerPendingTransactions();
    //customerBalance();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getEmail());
  }


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
          padding: const EdgeInsets.all(10.0),
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
              // height: MediaQuery.of(context).size.height/1.6,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Parking History",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 30,


                  ),


                  FutureBuilder<List<Parking>>(
                    future: customerParking(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        List<Parking>? parking = snapshot.data;
                        return customerParkingTransactionsAll(parking!);
                      } else if (snapshot.hasError) {
                        // return Text('${snapshot.error}');
                        return Text('No Parking History Yet');
                      }
                      //return  a circular progress indicator.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );


                    },


                  ),


                  const SizedBox(
                    height: 20,
                  ),





                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
