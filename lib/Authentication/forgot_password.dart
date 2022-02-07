import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/Authentication/login.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:laspa_customer/shared/shared.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_otp.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({Key? key}) : super(key: key);

  @override
  _forgot_passwordState createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  String username = '';

  String action = '1';


  Future <String>  customerLogin() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/customer_forgotpassword";
    final response = await http.post(url, body: {
      "username": username,
      "Action": action,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
    // print(message);


    if(message.contains("Invalid Phone Number or Email")){

      setState(() {
      });
      String message = "Email or Phone Number invalid";
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
    else{

      var localStorage = await SharedPreferences.getInstance();
      localStorage.setString('email',username);

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('phone',username);


      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => forgot_password_verification()));




    }
    return message;
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Forgot Password'),
          automaticallyImplyLeading: false,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset('assets/forgotpassword.png',
                            height: 100,
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 30.0),
                    Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FadeAnimation(1.3, Padding(
                              padding: EdgeInsets.symmetric(horizontal:40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Forgot Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: Text('View all',)
                                  // )
                                ],
                              ),
                            )),
                            SizedBox(height: 30.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Phone Number or Email'),
                                  validator: (val) => val!.isEmpty
                                      ? ' Phone Number or Email is required'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => username = val);
                                  }),
                            ),
                            SizedBox(height: 30.0),



                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                // padding: EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                    )),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () async {

                                    if(_formKey.currentState!.validate()){
                                      setState(() => loading = true);

                                      customerLogin();
                                    }



                                  },
                                  color: Color(0xffffcc00),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),


                              ),
                            ),


                            SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('A one time verification code will be sent to you in order to verify your account')),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
