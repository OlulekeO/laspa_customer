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

late final List<Customer> customer;

late String customerPhone;
late String customerEmail;



class Customer {
  final String ContactID;
  final String FirstName;
  final String LastName;
  final String PhoneNumber;
  final String Email;


  Customer({
    required this.ContactID,
    required this.FirstName,
    required this.LastName,
    required this.PhoneNumber,
    required this.Email,
  });

  factory Customer.fromJson(Map<String, dynamic> singleUser) {
    return Customer(
        ContactID: singleUser["ContactID"],
        FirstName: singleUser["FirstName"],
        LastName: singleUser["LastName"],
        PhoneNumber: singleUser["PhoneNumber"],
        Email: singleUser["Email"]);




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: customer.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(customer[currentIndex], context);
    },
  );
}



class customerProfile extends StatefulWidget {


  final List<Customer> customer;

  customerProfile(this.customer);

  @override
  _customerProfileState createState() => _customerProfileState();
}

class _customerProfileState extends State<customerProfile> {


  void initial() async{
    var localStorage = await SharedPreferences.getInstance();
    setState((){
      customerEmail = localStorage.getString('email');
      customerPhone = localStorage.getString('phone');
    });
  }
  @override

  Future getEmail()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = localStorage.getString('email');
      customerPhone = localStorage.getString('phone');
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
      itemCount: widget.customer.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.customer[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Customer customer, BuildContext context) {
  return ListTile(

   title: Column(


      children: <Widget> [


        Padding(
          padding: const EdgeInsets.only(
            left:0.0,
            right:0.0,
            top:10,
          ),
          child: Container(

            height:30.0,

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:30.0,
                right:30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Username',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(customer.FirstName + " " + customer.LastName),


                ],



              ),
            ),

          ),
        ),
        const SizedBox(
          height: 20,
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
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:30.0,
                right:30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Phone Number',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(customer.PhoneNumber),


                ],



              ),
            ),

          ),
        ),

        const SizedBox(
          height: 20,
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
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:30.0,
                right:30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Email',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(customer.Email),


                ],



              ),
            ),

          ),
        ),

        const SizedBox(
          height: 20,
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
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0),
              ),
            ),

            child:Padding(
              padding: const EdgeInsets.only(
                left:30.0,
                right:30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Plate Number',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Nil'),


                ],



              ),
            ),

          ),
        ),



      ],



    ),



  );

}