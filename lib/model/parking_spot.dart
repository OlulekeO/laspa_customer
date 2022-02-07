import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/PaymentMethod/payment_method.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/modal_screens/parking_area.dart';
import 'package:shared_preferences/shared_preferences.dart';



late final List<Spot> spot;

late String agentCode;



class Spot {
  final String ParkingSpotID;
  final String ParkingAreaID;
  final String ParkingSpotName;



  Spot({
    required this.ParkingSpotID,
    required this.ParkingAreaID,
    required this.ParkingSpotName,
  });

  factory Spot.fromJson(Map<String, dynamic> singleUser) {
    return Spot(
      ParkingSpotID: singleUser["ParkingSpotID"],
      ParkingAreaID: singleUser["ParkingAreaID"],
      ParkingSpotName: singleUser["ParkingSpotName"],

    );




  }


}



// Widget build(context) {
//   return ListView.builder(
//     itemCount: spot.length,
//     itemBuilder: (context, int currentIndex) {
//       return createUserView(spot[currentIndex], context);
//     },
//   );
// }



class parkingSpots extends StatefulWidget {


  final List<Spot> spot;

  parkingSpots(this.spot);

  @override
  _parkingSpotsState createState() => _parkingSpotsState();
}

class _parkingSpotsState extends State<parkingSpots> {


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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 6.0,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.spot.length,
      itemBuilder: (BuildContext context, int currentIndex) {
        return createUserView(widget.spot[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Spot spot, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [

        GestureDetector(
      onTap:() async {

        var ParkingSpotID = spot.ParkingSpotID;
        var parkingSpotName = spot.ParkingSpotName;

        var localStorage = await SharedPreferences.getInstance();
        localStorage.setString('ParkingSpotID',ParkingSpotID);
        localStorage.setString('parkingSpotName',parkingSpotName);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => payment_options(value: ParkingSpotID),
            ));



      },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              // height:45.0,

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2.0,
                ),
              ),

              child:Padding(
                padding: const EdgeInsets.only(
                  left:2.0,
                  right:2.0,
                ),
                child: Column(
                  children: [
                    Text(spot.ParkingSpotName,  style: TextStyle(fontSize: 16,)),
                    // Text(spot.ParkingSpotID,  style: TextStyle(fontSize: 16,)),



                  ],
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
