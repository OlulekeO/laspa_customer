import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/ussd_code_generation.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class payment_ussd extends StatefulWidget {
  const payment_ussd({Key? key}) : super(key: key);

  @override
  _payment_ussdState createState() => _payment_ussdState();
}

class _payment_ussdState extends State<payment_ussd> {


  List<String> property = [
    'GTB', 'FirstBank', 'UnionBank','ZenithBank','UBA','AccessBank','GlobusBank',
    'PolarisBank','FCMB','EcoBank','FidelityBank','HeritageBank','KeystoneBank','Titan',
    'UnityBank','Stanbic','StandardCharteredBank','SterlingBank','JaizBank'

  ];

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String dropdownStr =  'GTB';
  var amount= '';



  String customerEmail = '';
  String password = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      password = preferences.getString('password');
    });
  }


  Future <String>  customerUssdPayment() async {
    HttpClient client =  HttpClient();
   // client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/customer_Ussd_Generator";

    final response = await http.post(url, body: {
      "bank": dropdownStr,
      "amount": amount,
      "password": password,
      "customerEmail": customerEmail,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
    //print(message);


    if(message !=''){

      var localStorage = await SharedPreferences.getInstance();
      localStorage.setString('ussdcode',message);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => code_generation()));


    }
    else{
      setState(() {
      });
      String message = "Something went wrong!!!!!";
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








  void initState() {
    super.initState();
    getEmail();
  }

  @override


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

        child: Flexible(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
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
              height: MediaQuery.of(context).size.height/1.8,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("USSD",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 40,
                    ),

                    DropdownButton(
                      focusColor: Colors.redAccent,
                      hint: Text("Choose Bank"),
                      isExpanded: true,
                      value: dropdownStr,
                      icon: Icon(Icons.arrow_drop_down),
                      iconEnabledColor: Colors.redAccent,
                      iconSize: 30,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                        onChanged: (val) {
                          setState(() => dropdownStr);
                        },
                      items: property
                          .map<DropdownMenuItem<String>> ((String value){
                        return DropdownMenuItem<String> (
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),




                    TextField(
                      onChanged :(val){

                        setState(() => amount = val);
                      },
                      decoration: InputDecoration(
                        // icon: Icon(Icons.account_circle),
                        labelText: 'Amount',
                      ),
                    ),


                    const SizedBox(
                      height: 40,
                    ),



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {

                          if(_formKey.currentState!.validate()){
                            setState(() => loading = true);

                            customerUssdPayment();
                          }

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => code_generation()));
                        },
                        color: Color(0xffffcc00),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Generate Code",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),


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
