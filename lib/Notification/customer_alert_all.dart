import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/card_payment.dart';
import 'package:laspa_customer/PaymentMethod/ussd_payment.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/model/customer_messages.dart';
import 'package:laspa_customer/model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';


final _links = 'https://app.prananet.io/LaspaApp/Payment/cardpayment?i=';



class alert_customer extends StatefulWidget {
  const alert_customer({Key? key}) : super(key: key);

  @override
  _alert_customerState createState() => _alert_customerState();
}



String url = 'https://app.prananet.io/LaspaApp/Payment/cardpayment?i=';

String rightUrl = url;

class _alert_customerState extends State<alert_customer> {

  String customerEmail = '';
  String customerPhone = '';
  String password = '';

  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      customerPhone = preferences.getString('phone');
      password = preferences.getString('password');
    });
  }


  Future<List<AlertMessage>> customerAlertGet() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_notifications";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password": password,
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<AlertMessage> alertmessages = [];
    for (var singleUser in responseData) {
      AlertMessage alertmessage = AlertMessage(
          NotificationID: singleUser["NotificationID"],
          Title: singleUser["Title"],
          Body: singleUser["Body"],
          NotificationStatus: singleUser["NotificationStatus"],
          DateCreated: singleUser["DateCreated"],
          ReceiverType: singleUser["ReceiverType"]
      );

      //Adding user to the list.
      alertmessages.add(alertmessage);

    }
    return alertmessages;

  }






  //String email = 'olulekeodunuga@yahoo.com';


  @override
  void initState() {
    super.initState();
    getEmail();

  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Notifications',
            style: TextStyle(color: Colors.black),
          ),
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
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {


                Navigator.push(context, MaterialPageRoute(builder: (context) => alert_customer()));

              },
              icon: Icon(
                Icons.notifications_none,
                color: Colors.grey.shade700,
                size: 30,
              ),
            )
          ],

        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[






              FutureBuilder<List<AlertMessage>>(
                future: customerAlertGet(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<AlertMessage>? alertmessage = snapshot.data;
                    return customerAlert(alertmessage!);
                  } else if (snapshot.hasError) {
                   // return Text('${snapshot.error}');
                    return const Center(child: Text('No Notification'));
                    // return Text('No Report Yet');
                  }
                  //return  a circular progress indicator.
                  return Container(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );


                },


              ),




            ],

          ),
        ),
      ),
    );
  }
}
void _handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => cardPayment(url+customerEmail)));
}