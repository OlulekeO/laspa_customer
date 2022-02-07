import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:laspa_customer/shared/shared.dart';

import 'login.dart';

const Color primaryColor = Color(0xFF121212);
const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);





class password_reset extends StatefulWidget {
  const password_reset({Key? key}) : super(key: key);

  @override
  _password_resetState createState() => _password_resetState();
}

class _password_resetState extends State<password_reset> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String otp = '';
  String customerEmail = '';
  String customerPhone = '';
  String password = '';


  String action = '1';
  @override


  void initState() {
    super.initState();
    _loadCounter();
    //getRequest();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = (prefs.getString('email')??'');
      customerPhone = (prefs.getString('phone')??'');
      password = (prefs.getString('password')??'');


    });
  }
  @override




  Future <String>  Customer_OTP_Verification() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/customer_newpassword";
    final response = await http.post(url, body: {
      "password": password,
      "username": customerEmail,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
    print(message);


    if(message.contains("Password Reset successful")){

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => customer_login()));


    }
    else{
      setState(() {
      });
      String message = "Invalid Code";
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
    return message;
  }





  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('OTP Verification'),
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
                            child: Image.asset('assets/LagosLogo.png'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset('assets/LASPAo.png'),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FadeAnimation(1.3, Padding(
                              padding: EdgeInsets.symmetric(horizontal:40),
                              child:  Text('New Password', style: TextStyle(fontSize: 16),),
                            )),

                            SizedBox(height: 20.0),
                            Text(customerEmail, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 40.0),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Password'),
                                  validator: (val) => val!.length < 1
                                      ? ' Enter a password 1+ chars long'
                                      : null,
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  }),
                            ),

                            SizedBox(height: 40.0),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 40),
                            //   child: Column(
                            //     children: <Widget>[
                            //       inputFile(label: "Username"),
                            //       inputFile(label: "Password", obscureText: true)
                            //     ],
                            //   ),
                            // ),

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

                                      Customer_OTP_Verification();
                                    }


                                  },
                                  color: Color(0xffffcc00),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Verify",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
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
