import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/agent_result.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class agent_verification extends StatefulWidget {
  const agent_verification({Key? key}) : super(key: key);

  @override
  _agent_verificationState createState() => _agent_verificationState();
}

class _agent_verificationState extends State<agent_verification> {


  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String agentCode = '';

  String customerEmail = '';
  String password = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      password = preferences.getString('password');
    });
  }

  Future <String>  agentVerification() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/enforcement_marshal_check";
    final response = await http.post(url, body: {
      "enforcementcode": agentCode,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
    print(message);



    if(message.contains("Successful")){

      var localStorage = await SharedPreferences.getInstance();
      localStorage.setString('agentCode',agentCode);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => agent_verification_result()));


    }
    else{
      setState(() {
      });
      String message = "Marshal does not exist!!";
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
            height: MediaQuery.of(context).size.height/2.4,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form(
              key:  _formKey,
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Agent Verification",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 40,
                  ),

                  TextField(
                    onChanged :(val){

                      setState(() => agentCode = val);
                    },
                    decoration: InputDecoration(
                      // icon: Icon(Icons.account_circle),
                      labelText: 'Agent Code',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);

                          agentVerification();
                        }



                        //Navigator.push(context, MaterialPageRoute(builder: (context) => agent_verification_result()));
                      },
                      color: Color(0xffffcc00),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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


                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
