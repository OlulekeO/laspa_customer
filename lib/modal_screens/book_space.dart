import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/model/parking_locations.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class book_parkingspace extends StatefulWidget {
  const book_parkingspace({Key? key}) : super(key: key);

  @override
  _book_parkingspaceState createState() => _book_parkingspaceState();
}

class _book_parkingspaceState extends State<book_parkingspace> {


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


  Future<List<Location>> getParkinglocations() async {


    String url = "https://app.prananet.io/LaspaApp/Api/parking_locations";
    final response = await http.post(url, body: {
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Location> locations = [];
    for (var singleUser in responseData) {
      Location location = Location(
        ParkingAreaID: singleUser["ParkingAreaID"],
        parkingfee: singleUser["parkingfee"],
        parkingareaname: singleUser["parkingareaname"],
        Cityname: singleUser["Cityname"]
      );

      //Adding user to the list.
      locations.add(location);

    }
    return locations;

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

      body: SingleChildScrollView(
        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
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
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Parking Locations",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 30,                //
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left:0.0,
                    //     right:0.0,
                    //     top:10,
                    //   ),
                    //   child: Container(
                    //
                    //     height:30.0,
                    //
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             color: Colors.grey.shade300, width: 1.0),
                    //       ),
                    //     ),
                    //
                    //     child:Padding(
                    //       padding: const EdgeInsets.only(
                    //         left:5.0,
                    //         right:5.0,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //         children: [
                    //           Text('Ikorodu Park',  style: TextStyle(fontSize: 20,)),
                    //           Image.asset(
                    //             'assets/Arrow.png',
                    //             height: 20,
                    //           ),
                    //
                    //
                    //         ],
                    //
                    //
                    //
                    //       ),
                    //     ),
                    //
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //
                    //
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left:0.0,
                    //     right:0.0,
                    //     top:10,
                    //   ),
                    //   child: Container(
                    //
                    //     height:30.0,
                    //
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             color: Colors.grey.shade300, width: 1.0),
                    //       ),
                    //     ),
                    //
                    //     child:Padding(
                    //       padding: const EdgeInsets.only(
                    //         left:5.0,
                    //         right:5.0,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //         children: [
                    //           Text('Ketu Parks',  style: TextStyle(fontSize: 20,)),
                    //           Image.asset(
                    //             'assets/Arrow.png',
                    //             height: 20,
                    //           ),
                    //
                    //
                    //         ],
                    //
                    //
                    //
                    //       ),
                    //     ),
                    //
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left:0.0,
                    //     right:0.0,
                    //     top:10,
                    //   ),
                    //   child: Container(
                    //
                    //     height:30.0,
                    //
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             color: Colors.grey.shade300, width: 1.0),
                    //       ),
                    //     ),
                    //
                    //     child:Padding(
                    //       padding: const EdgeInsets.only(
                    //         left:5.0,
                    //         right:5.0,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //         children: [
                    //           Text('Vi Park',  style: TextStyle(fontSize: 20)),
                    //           Image.asset(
                    //             'assets/Arrow.png',
                    //             height: 20,
                    //           ),
                    //
                    //
                    //         ],
                    //
                    //
                    //
                    //       ),
                    //     ),
                    //
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                  ),


                  FutureBuilder<List<Location>>(
                    future: getParkinglocations(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        List<Location>? location = snapshot.data;
                        return parkingLocations(location!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                        return Text('No Report Yet');
                      }
                      //return  a circular progress indicator.
                      return Container(
                        child: const Center(
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
