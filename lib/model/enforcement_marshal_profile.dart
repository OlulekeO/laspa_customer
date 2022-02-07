import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Customer {
//   final String ContactID;
//   final String FirstName;
//   final String LastName;
//   final String PhoneNumber;
//   final String Email;
//
//   Customer(this.ContactID, this.FirstName, this.LastName, this.PhoneNumber, this.Email);
// }

late final List<Enforcement> enforcement;

late String agentCode;



class Enforcement {
  final String EnforcementMarshalID;
  final String EnforcementCode;
  final String FirstName;
  final String LastName;
  final String Email;
  final String Phonenumber;
  final String Location;
  final String PictureUrl;
  final String CityName;
  final String ParkingArea;


  Enforcement({
    required this.EnforcementMarshalID,
    required this.EnforcementCode,
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.Phonenumber,
    required this.Location,
    required this.PictureUrl,
    required this.CityName,
    required this.ParkingArea,
  });

  factory Enforcement.fromJson(Map<String, dynamic> singleUser) {
    return Enforcement(
        EnforcementMarshalID: singleUser["EnforcementMarshalID"],
        EnforcementCode: singleUser["EnforcementCode"],
        FirstName: singleUser["FirstName"],
        LastName: singleUser["LastName"],
        Email: singleUser["Email"],
        Phonenumber: singleUser["Phonenumber"],
        Location: singleUser["Location"],
        CityName: singleUser["CityName"],
        ParkingArea: singleUser["ParkingArea"],
        PictureUrl: "https://app.prananet.io/LaspaApp/ProfilePicture/"+singleUser["PictureUrl"]

    );




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: enforcement.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(enforcement[currentIndex], context);
    },
  );
}



class enforcementProfile extends StatefulWidget {


  final List<Enforcement> enforcement;

  enforcementProfile(this.enforcement);

  @override
  _enforcementProfileState createState() => _enforcementProfileState();
}

class _enforcementProfileState extends State<enforcementProfile> {


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
      itemCount: widget.enforcement.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.enforcement[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Enforcement enforcement, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(enforcement.PictureUrl,),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all( Radius.circular(50.0)),
                  border: Border.all(
                    color: Color(0xffffCC00),
                    width: 4.0,
                  ),
                ),
              ),
            ),


          ],
        ),
        const SizedBox(
          height: 30,
        ),


        Padding(
          padding: const EdgeInsets.only(
            left:0.0,
            right:0.0,
            top:10,
          ),
          child: Container(

            height:30.0,

            decoration: BoxDecoration(

              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:0.0,
                right:20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Name',  style: TextStyle(fontSize: 20)),
                  Text(enforcement.FirstName + " " +enforcement.LastName ),


                ],



              ),
            ),

          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left:0.0,
            right:0.0,
            top:10,
          ),
          child: Container(

            height:30.0,

            decoration: BoxDecoration(

              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:0.0,
                right:20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Email',  style: TextStyle(fontSize: 20)),
                  Text(enforcement.Email),


                ],



              ),
            ),

          ),
        ),


        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left:0.0,
            right:0.0,
            top:10,
          ),
          child: Container(

            height:30.0,

            decoration: BoxDecoration(

              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:0.0,
                right:20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Phone Number',  style: TextStyle(fontSize: 20)),
                  Text(enforcement.Phonenumber),


                ],



              ),
            ),

          ),
        ),


        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left:0.0,
            right:0.0,
            top:10,
          ),
          child: Container(

            height:30.0,

            decoration: BoxDecoration(

              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:0.0,
                right:20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Park',  style: TextStyle(fontSize: 20)),
                  Text(enforcement.CityName + " " + enforcement.ParkingArea),


                ],



              ),
            ),

          ),
        ),

      ],



    ),



  );

}