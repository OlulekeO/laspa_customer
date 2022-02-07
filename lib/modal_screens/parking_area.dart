import 'package:flutter/material.dart';
import 'package:laspa_customer/model/parking_locations.dart';
import 'package:laspa_customer/model/parking_spot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';



class parkingArea extends StatefulWidget {
  const parkingArea({Key? key, required String value}) : super(key: key);

  @override
  _parkingAreaState createState() => _parkingAreaState();
}

class _parkingAreaState extends State<parkingArea> {




  String customerEmail = '';
  String password = '';
  String customerPhone = '';
  String pid = '';
  String parkingID = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      password = preferences.getString('password');
      customerEmail = preferences.getString('email');
      pid = preferences.getString('pid');
    });
  }



  Future<List<Spot>> getParkingSpots() async {


    String url = "https://app.prananet.io/LaspaApp/Api/parking_spot";
    final response = await http.post(url, body: {
      "parkingID": pid,
    });

    var responseData = json.decode(response.body);
     //print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Spot> spots = [];
    for (var singleUser in responseData) {
      Spot spot = Spot(
        ParkingSpotID: singleUser["ParkingSpotID"],
        ParkingAreaID: singleUser["ParkingAreaID"],
        ParkingSpotName: singleUser["ParkingSpotName"],
      );

      //Adding user to the list.
      spots.add(spot);

    }
    return spots;

  }


  Future<List<Spot>> getParkinglocations1() async {


    String url = "https://app.prananet.io/LaspaApp/Api/parking_spot";
    final response = await http.post(url, body: {
      "parkingID": pid,
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Spot> spots = [];
    for (var singleUser in responseData) {
      Spot spot = Spot(
        ParkingSpotID: singleUser["ParkingSpotID"],
        ParkingAreaID: singleUser["ParkingAreaID"],
        ParkingSpotName: singleUser["ParkingSpotName"],
      );

      //Adding user to the list.
      spots.add(spot);

    }
    return spots;

  }



  @override

  void initState() {
    super.initState();
    getEmail();
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
          padding: const EdgeInsets.all(20.0),
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



            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffFFCC01),


                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)

                    ),

                  ),

                  child:  Center(child: Text("Free Lanes",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

                ),
                const SizedBox(
                  height: 10,
                ),



                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  child:  FutureBuilder<List<Spot>>(
                    future: getParkinglocations1(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        List<Spot>? spot = snapshot.data;
                        return parkingSpots(spot!);
                      } else if (snapshot.hasError) {
                        return Center(child: Text('No Available Spot'));
                        return Text('No Report Yet');
                      }
                      //return  a circular progress indicator.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );


                    },


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
