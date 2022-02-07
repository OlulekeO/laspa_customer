import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:laspa_customer/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_authentication.dart';





class customerRegistration extends StatefulWidget {
  const customerRegistration({Key? key}) : super(key: key);

  @override
  _customerRegistrationState createState() => _customerRegistrationState();
}

class _customerRegistrationState extends State<customerRegistration> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String password = '';

  String action = '1';
  @override
  Widget build(BuildContext context) {





    Future <String>  customerRegistration() async {
      HttpClient client = new HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      String url = "https://app.prananet.io/LaspaApp/Api/customer_registration";
      final response = await http.post(url, body: {
        "firstName": firstName,
        "lastName": lastName,
        "phonenumber": phone,
        "password": password,
        "Action": action,
        "email": email,
      });
      String responseData = json.encode(response.body);
      String message = json.decode(responseData);
      print(message);


      if(message.contains("Customer created successfully")){
       
        var localStorage = await SharedPreferences.getInstance();
        localStorage.setString('email',email);

        localStorage = await SharedPreferences.getInstance();
        localStorage.setString('phone',phone);

        localStorage = await SharedPreferences.getInstance();
        localStorage.setString('password',password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => customer_verification()));


      }
      else{
        setState(() {
        });
        String message = "Customer already exists";
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



    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Register'),
          automaticallyImplyLeading: false,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
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
              height: MediaQuery.of(context).size.height * 2.0,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: Text('View all',)
                                  // )
                                ],
                              ),
                            )),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'First Name'),
                                  validator: (val) => val!.isEmpty
                                      ? ' First Name is required'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => firstName = val);
                                  }),
                            ),
                            SizedBox(height: 10.0),



                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Last Name'),
                                  validator: (val) => val!.isEmpty
                                      ? ' Last Name is required'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => lastName = val);
                                  }),
                            ),
                            SizedBox(height: 10.0),


                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Email'),
                                  validator: (val) => val!.isEmpty
                                      ? ' Email is required'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  }),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Phone Number'),
                                  validator: (val) => val!.isEmpty
                                      ? ' Phone Number is required'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => phone = val);
                                  }),
                            ),
                            SizedBox(height: 10.0),
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
                            SizedBox(height: 30.0),
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
                                    borderRadius: BorderRadius.circular(30),
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

                                      customerRegistration();
                                    }


                                  },
                                  color: Color(0xffffcc00),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Register",
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