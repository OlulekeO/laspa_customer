import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/Notification/customer_alert_all.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:laspa_customer/model/custome_profile.dart';
import 'package:laspa_customer/model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class customer_profile extends StatefulWidget {
  const customer_profile({Key? key}) : super(key: key);

  @override
  _customer_profileState createState() => _customer_profileState();
}

class _customer_profileState extends State<customer_profile> {




  String customerEmail = '';
  String customerPhone = '';
  String password = '';

  //get the Customer's Login details from the session
  Future getCustomerDetails()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      customerPhone = preferences.getString('phone');
      password = preferences.getString('password');


    });
  }

//get the customer's details from the API
  Future<List<User>> getRequest() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_profile_get_ByID";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password": password,
      "Action": '1',
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(
          ContactID: singleUser["ContactID"],
          FirstName: singleUser["FirstName"],
          LastName: singleUser["LastName"],
          PhoneNumber: singleUser["PhoneNumber"],
          Email: singleUser["Email"]);

      //Adding user to the list.
      users.add(user);

    }
    return users;

  }


  Future<List<Customer>> getCustomerProfile() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_profile_get_ByID";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password": password,
      "Action": '1',
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Customer> customers = [];
    for (var singleUser in responseData) {
      Customer customer = Customer(
          ContactID: singleUser["ContactID"],
          FirstName: singleUser["FirstName"],
          LastName: singleUser["LastName"],
          PhoneNumber: singleUser["PhoneNumber"],
          Email: singleUser["Email"]);

      //Adding user to the list.
      customers.add(customer);

    }
    return customers;

  }




  @override

  void initState() {
    super.initState();
    getCustomerDetails();
    getRequest();
    getCustomerProfile();
  }


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFCC01),
          // title: Text(
          //   'Profile',
          //   style: TextStyle(color: Colors.black),
          // ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {


                Navigator.push(context, MaterialPageRoute(builder: (context) => const alert_customer()));


              },
              icon: Icon(
                Icons.refresh,
                color: Colors.grey.shade700,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: Colors.grey.shade700,
                size: 30,
              ),
            )
          ],

          leadingWidth: 150,
          leading: Center(
            child: FutureBuilder<List<User>>(
              future: getRequest(),
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  List<User>? user = snapshot.data;
                  return customerList(user!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                  return Text('No Report Yet');
                }
                //return  a circular progress indicator.
                return Text('');


              },


            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[




              FadeAnimation(
                  1.2,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      height: 170,
                      decoration: BoxDecoration(
                        color: Color(0xffFFCC01),
                        borderRadius: BorderRadius.only(

                            bottomRight:Radius.circular(10),
                            bottomLeft:Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(0, 4),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  height: 100,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 90,
                                    child: Image.asset(
                                      "assets/camera.png",
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),






                        ],


                      ),

                    ),
                  )),
              const SizedBox(
                height: 50,
              ),




              FutureBuilder<List<Customer>>(
                future: getCustomerProfile(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<Customer>? customer = snapshot.data;
                    return customerProfile(customer!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                    return Text('No Report Yet');
                  }
                  //return  a circular progress indicator.
                  return Text('');


                },


              ),







              // Padding(
              //   padding: const EdgeInsets.all(50.0),
              //   child: MaterialButton(
              //     minWidth: double.infinity,
              //     height: 60,
              //     onPressed: () async {
              //
              //
              //
              //     },
              //     color: Color(0xffffffff),
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Text(
              //       "Edit Profile",
              //       style: TextStyle(
              //         fontWeight: FontWeight.w600,
              //         fontSize: 18,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 40,
              ),
          OutlinedButton(
            onPressed: null,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            ),
            child: const Text("Edit Profile",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),),
          ),


            ],

          ),
        ),
      ),
    );
  }
}
