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

late final List<User> user;

late String customerPhone;
late String customerEmail;



class User {
  final String ContactID;
  final String FirstName;
  final String LastName;
  final String PhoneNumber;
  final String Email;


  User({
    required this.ContactID,
    required this.FirstName,
    required this.LastName,
    required this.PhoneNumber,
    required this.Email,
  });

  factory User.fromJson(Map<String, dynamic> singleUser) {
    return User(
        ContactID: singleUser["ContactID"],
        FirstName: singleUser["FirstName"],
        LastName: singleUser["LastName"],
        PhoneNumber: singleUser["PhoneNumber"],
        Email: singleUser["Email"]);




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: user.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(user[currentIndex], context);
    },
  );
}



class customerList extends StatefulWidget {


  final List<User> user;

  customerList(this.user);

  @override
  _customerListState createState() => _customerListState();
}

class _customerListState extends State<customerList> {


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
      itemCount: widget.user.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.user[currentIndex], context);
      },
    );
  }


}


Widget createUserView(User user, BuildContext context) {
  return ListTile(
      title: new   Column(
        children:<Widget> [

              Text('Hello ' + user.FirstName,style: TextStyle(color: Colors.black, fontSize: 15),),


        ],
      ),


);

}