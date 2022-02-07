import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:laspa_customer/shared/shared.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';

class customer_login extends StatefulWidget {
  const customer_login({Key? key}) : super(key: key);

  @override
  _customer_loginState createState() => _customer_loginState();
}

class _customer_loginState extends State<customer_login> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  String username = '';
  String password = '';

  String action = '1';


  Future <String>  customerLogin() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/customer_login";
    final response = await http.post(url, body: {
      "username": username,
      "password": password,
      "Action": action,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
   // print(message);


    if(message.contains("Customer Login Successful")){

      var localStorage = await SharedPreferences.getInstance();
      localStorage.setString('email',username);

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('phone',username);

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('password',password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));


    }
    else{
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
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() => loading = false);
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
          title: Text('Login'),
          automaticallyImplyLeading: false,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Text('View all',)
                              // )
                            ],
                          ),
                        )),
                        SizedBox(height: 10.0),
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
                     

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            // padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: const Border(
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

                              child: (loading)
                                  ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                  )): const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),


                          ),
                        ),

                        SizedBox(height: 10.0),
                        GestureDetector(

                          onTap: (){


                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => forgot_password()));

                          },

                            child: Text('Forgot Password')),
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
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: const InputDecoration(
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
