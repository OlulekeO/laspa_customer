import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/modal_screens/parking_area.dart';
import 'package:shared_preferences/shared_preferences.dart';



late final List<Location> location;

late String agentCode;



class Location {
  final String ParkingAreaID;
  final String parkingfee;
  final String parkingareaname;
  final String Cityname;


  Location({
    required this.ParkingAreaID,
    required this.parkingfee,
    required this.parkingareaname,
    required this.Cityname,
  });

  factory Location.fromJson(Map<String, dynamic> singleUser) {
    return Location(
        ParkingAreaID: singleUser["ParkingAreaID"],
        parkingfee: singleUser["parkingfee"],
        parkingareaname: singleUser["parkingareaname"],
        Cityname: singleUser["Cityname"],
    );




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: location.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(location[currentIndex], context);
    },
  );
}



class parkingLocations extends StatefulWidget {


  final List<Location> location;

  parkingLocations(this.location);

  @override
  _parkingLocationsState createState() => _parkingLocationsState();
}

class _parkingLocationsState extends State<parkingLocations> {


  void initial() async{
    var localStorage = await SharedPreferences.getInstance();
    setState((){
      agentCode = localStorage.getString('agentCode');
    });
  }
  @override

  Future getEmail()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      agentCode = localStorage.getString('agentCode');
    });
  }
  @override
  void initState() {
    super.initState();
    getEmail();
    //getRequest();
  }



  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.location.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.location[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Location location, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [

        GestureDetector(
          onTap:() async {

            // Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));

            // var route = MaterialPageRoute(
            //   builder: (BuildContext context) =>
            //   new parkingArea(value: location),
            // );
            // Navigator.of(context).push(route);
            //Navigator.of(context).pop(location.ParkingAreaID);
            var pid = location.ParkingAreaID;
            //get the parking fee
            var parkingAmount = location.parkingfee;
            var cityName = location.Cityname;
            var parkingLocationName = location.parkingareaname;


            //save user's location to a session
            var localStorage = await SharedPreferences.getInstance();
            localStorage.setString('pid',pid);
            localStorage.setString('parkingAmount',parkingAmount);
            localStorage.setString('cityName',cityName);
            localStorage.setString('parkingLocationName',parkingLocationName);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => parkingArea(value: pid),
                ));

          },

          child: Padding(
            padding: const EdgeInsets.only(
              left:0.0,
              right:0.0,
              top:10,
            ),
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),

                // height:30.0,

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.shade300, width: 1.0),
                  ),
                ),

                child:Padding(
                  padding: const EdgeInsets.only(
                    left:1.0,
                    right:1.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(location.parkingareaname + " " + "(" + location.Cityname + ")",  style: TextStyle(fontSize: 14,))),
                      Image.asset(
                        'assets/Arrow.png',
                        height: 20,
                      ),


                    ],



                  ),
                ),

              ),
            ),
          ),
        ),

      ],



    ),



  );

}
// class parkingArea extends StatefulWidget {
//   final String value;
//
//
//
//
//
//
//   parkingArea({Key? key, required this.value}) : super(key: key);
//
//   @override
//   _parkingAreaState createState() => _parkingAreaState();
// }
//
// class _parkingAreaState extends State<parkingArea> {
//
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   setState(() {
//   password = preferences.getString('password');
//   agentCode = preferences.getString('agentCode');
//   customerEmail = preferences.getString('email');
//   customerPhone = preferences.getString('phone');
//   });
// //  print('${widget.value.ParkingAreaID}'),
//   String test = 'yea';
//
//
//   @override
//
//
//   Widget build(BuildContext context) {
//     return Container(
//
//
//       child: Text(test),
//
//     );
//   }
// }
