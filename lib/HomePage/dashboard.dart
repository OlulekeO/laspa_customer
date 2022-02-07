import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/Notification/customer_alert_all.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:laspa_customer/modal_screens/add_hour.dart';
import 'package:laspa_customer/modal_screens/book_space.dart';
import 'package:laspa_customer/modal_screens/customer_checkout.dart';
import 'package:laspa_customer/modal_screens/parking_history_all.dart';
import 'package:laspa_customer/modal_screens/qrcode_scanner.dart';
import 'package:laspa_customer/modal_screens/verify_agent.dart';
import 'package:laspa_customer/model/customer_messages.dart';
import 'package:laspa_customer/model/customer_balance.dart';
import 'package:laspa_customer/model/customer_parking_transactions.dart';
import 'package:laspa_customer/model/service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
String formattedDate = '';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String ussdbank = '';
  String ussdplatenumber = '';
  String ussdamount = '';
  var customerWalletBalance = '';


  _onAlertWithCustomContentPressed(context) {
    Alert(
      context: context,
      title: "Push Link",
      buttons: [],
      content: Form(
        key:  _formKey,
        child: Column(
          children: <Widget>[
            TextField(
              onChanged :(val){
                setState(() => ussdbank = val);
              },
              decoration: const InputDecoration(
                // icon: Icon(Icons.account_circle),
                labelText: 'Bank',
              ),
            ),
            TextField(
              onChanged :(val){
                setState(() => ussdplatenumber = val);
              },
              decoration: const InputDecoration(
                // icon: Icon(Icons.account_circle),
                labelText: 'PlateNumber',
              ),
            ),
            TextField(
              onChanged :(val){
                setState(() => ussdamount = val);
              },
              decoration: const InputDecoration(
                // icon: Icon(Icons.account_circle),
                labelText: 'Amount',
              ),
            ),
            // TextField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     // icon: Icon(Icons.lock),
            //     labelText: 'Duration',
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const Text(
                  ' *737*2*1000',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                MaterialButton(
                  // minWidth: double.infinity,
                  height: 30,
                  color: Color(0xffffcc00),
                  onPressed: () {
                    // paywithussd();

                    // Codegenerate();
                    // String message = "Ussd code on its way";
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: new Text(GeneratedUSSDCode),
                    //       actions: <Widget>[
                    //         FlatButton(
                    //           child: new Text(GeneratedUSSDCode),
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );


                  },
                  // defining the shape
                  shape: RoundedRectangleBorder(

                    // side: BorderSide(
                    //     color: Colors.black
                    // ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "PushLink",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).show();
  }


  String customerEmail = '';
  String customerPhone = '';
  String password = '';


  getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      customerEmail = preferences.getString('email');
      customerPhone = preferences.getString('phone');
      password = preferences.getString('password');
    });
  }


  Future<List<User>> getRequest() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_profile_get_ByID";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password":password,
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


  Future<List<Balance>> customerAccount() async {


    final jsonEndpoint = "https://app.prananet.io/LaspaApp/Api/customerBalance";

    final response = await http.post(jsonEndpoint, body: {
      "email": customerEmail,
      "password":password,
      "Action": '1',
    });

    if (response.statusCode == 200) {
      List balances = json.decode(response.body);
     // print(balances);

      return balances
          .map((balance) => Balance.fromJson(balance))
          .toList();
    } else {
      throw Exception('Loading');
    }
  }

  Future<List<Parking>> customerParking() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_parking_transactions";
    final response = await http.post(url, body: {
      "email": customerEmail,
      "password":password,
      "Action": '1',
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Parking> parkings = [];
    for (var singleUser in responseData) {
      Parking parking = Parking(
        ParkingID: singleUser["ParkingID"],
        ContactID: singleUser["ContactID"],
        Amount: singleUser["Amount"],
        PlateNumber: singleUser["PlateNumber"],
        ParkingTime: singleUser["ParkingTime"],
        ParkingHour: singleUser["ParkingHour"],
        Parkingstatus: singleUser["Parkingstatus"],
        ParkingAreaID: singleUser["ParkingAreaID"],
        ParkingSpotID: singleUser["ParkingSpotID"],
        ParkingAreaName: singleUser["ParkingAreaName"],
        channel: singleUser["channel"],
        ExpiringTime: singleUser["ExpiringTime"],
        Location: singleUser["Location"],
        ParkingSpotName: singleUser["ParkingSpotName"],
        DateAdded: singleUser["DateAdded"],
        CheckoutTime: singleUser["CheckoutTime"],

        qrcode: "https://app.prananet.io/LaspaApp/Qrcode/"+singleUser["Qrimage"],

      );

      //Adding user to the list.
      parkings.add(parking);

    }
    return parkings;

  }

  Future<List<Parking>> customerAccount1() async {


    final jsonEndpoint = "https://app.prananet.io/LaspaApp/Api/customer_parking_transactions";

    final response = await http.post(jsonEndpoint, body: {
      "email": customerEmail,
      "password":password,
      "Action": '1',
    });

    if (response.statusCode == 200) {
      List parkings = json.decode(response.body);
      // print(balances);

      return parkings
          .map((parking) => Parking.fromJson(parking))
          .toList();
    } else {
      throw Exception('We were not able to successfully download the json data.');
    }
  }




  Future<String> customerBalance() async {
    String url = "https://app.prananet.io/LaspaApp/Api/customer_wallet_balance";
    final response = await http.post(url, body: {
      "email":customerEmail,
      "password":password,
      "Action": '1',
    });

    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
    //print (message);


    var localStorage = await SharedPreferences.getInstance();
    localStorage.setString('customerWalletBalance',message);

    setState(() {
      customerWalletBalance = localStorage.getString('customerWalletBalance');
    });

    //print(customerBalance);
    return message;



  }


  late GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  void initState() {
    super.initState();
   // getEmail();
    // customerPendingTransactions();
    //customerBalance();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getEmail());
    WidgetsBinding.instance!.addPostFrameCallback((_) => customerBalance());
    _scaffoldKey = GlobalKey();
  }


  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Dashboard',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {




                Navigator.push(context, MaterialPageRoute(builder: (context) => alert_customer()));


              },
              icon: Icon(
                Icons.notification_important_outlined,
                color: Colors.red.shade700,
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
        return Text('Hello User');
        return Text('No Report Yet');
      }
      //return  a circular progress indicator.
      return new Text('');


    },


                ),
              ),
        ),
        body: RefreshIndicator(

          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
                  () {
                /// adding elements in list after [1 seconds] delay
                /// to mimic network call
                ///
                /// Remember: [setState] is necessary so that
                /// build method will run again otherwise
                /// list will not show all elements
                setState(() {
                  customerAccount();
                  customerParking();

                });

                // showing snackbar
                _scaffoldKey.currentState!.showSnackBar(
                  const SnackBar(
                    content: Text('Page Refreshed'),
                  ),
                );
              },
            );

          },
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.2,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          // height: 190,
                          decoration: BoxDecoration(
                            color: Color(0xffFFCC01),
                            borderRadius: BorderRadius.circular(20.0),
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
                          height: 4,
                        ),
                        const Text(
                          'Your Balance',
                          textAlign: TextAlign.left,
                        ),



                        FutureBuilder<List<Balance>>(
                          future: customerAccount(),
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          builder: (context, snapshot) {


                            if (snapshot.hasData) {
                              List<Balance>? balances = snapshot.data;
                              return CustomListView9(balances!);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                              return Text('No Report Yet');
                            }
                            //return  a circular progress indicator.
                            return new Text('');


                          },

                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Image.asset(
                                'assets/LASPAo.png',
                                height: 40,
                              ),
                            ),
                          ],
                        ),


                        Text(formattedDate,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),



                      ],


                    ),
                        ),
                      )),


                  SizedBox(height: 20,),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 10),
                  //   height: 120,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: services.length,
                  //       itemBuilder:
                  //           (BuildContext context, int index) {
                  //         return FadeAnimation(
                  //             (1.0 + index) / 4,
                  //             serviceContainer(
                  //                 services[index].imageURL,
                  //                 services[index].name,
                  //                 index));
                  //       }),
                  // ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(

                        children: [

                          GestureDetector(


                            child: Container(

                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),




                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Pay with Qr',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/Qr.png", height: 45),
                                  ]),
                            ),
                            onTap:() {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => qrcode_scanner()));


                              // _onAlertWithCustomContentPressed(context);

                            },
                          ),

                          GestureDetector(

                            child: Container(

                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Book space',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/bookspace.png", height: 45),
                                  ]),
                            ),
                            onTap:() {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => book_parkingspace()));


                              // _onAlertWithCustomContentPressed(context);

                            },
                          ),
                          GestureDetector(
                              onTap:() {

                                Navigator.push(context, MaterialPageRoute(builder: (context) => add_hour()));


                                // _onAlertWithCustomContentPressed(context);

                              },

                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Add Hour',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/Add.png", height: 45),
                                  ]),
                            ),
                          ),

                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Verify agent',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/Verification.png", height: 45),
                                  ]),
                            ),

                            onTap:() {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => agent_verification()));


                              // _onAlertWithCustomContentPressed(context);

                            },
                          ),


                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Checkout',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("assets/checkout.png", height: 45),
                                  ]),
                            ),

                            onTap:() {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => checkout_preview()));


                              // _onAlertWithCustomContentPressed(context);

                            },
                          ),



                        ],


                      ),
                    ),
                  ),


                  // Padding(
                  //   padding: const EdgeInsets.only(right:8.0),
                  //   child: Container(
                  //     height:50,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(
                  //         color: Colors.grey.shade200,
                  //         width: 2.0,
                  //       ),
                  //       borderRadius: BorderRadius.circular(7.0),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(5.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Image.asset(
                  //             'assets/airtime.png',
                  //             height: 30,
                  //           ),
                  //           Text('Buy Airtime'),
                  //         ],
                  //
                  //
                  //
                  //       ),
                  //     ),
                  //
                  //   ),
                  // ),



                  FadeAnimation(1.3, Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0,top:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        TextButton(
                            onPressed:() {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => parkingHistoryAll()));


                              // _onAlertWithCustomContentPressed(context);

                            },
                            child: Text('View all',)
                        )
                      ],
                    ),
                  )),


                  FutureBuilder<List<Parking>>(
                    future: customerAccount1(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        List<Parking>? parkings = snapshot.data;
                        return customerParkingTransactions(parkings!);
                      } else if (snapshot.hasError) {
                        // return Text('${snapshot.error}');
                        return Center(child: Text('No Parking Transactions yet'));
                        // return Text('No Report Yet');
                      }
                      //return  a circular progress indicator.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );


                    },


                  ),



                  FadeAnimation(1.3, Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0,top:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Other Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        // TextButton(
                        //     onPressed: () {},
                        //     child: Text('View all',)
                        // )
                      ],
                    ),
                  )),
                  Padding(
               padding: const EdgeInsets.all(20.0),
               child: Container(

                     decoration: BoxDecoration(
                       color: Colors.white,

                       borderRadius: BorderRadius.circular(7.0),
                     ),

child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

   Expanded(
     child: Padding(
       padding: const EdgeInsets.only(right:8.0),
       child: Container(
           height:50,
           decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(
               color: Colors.grey.shade200,
               width: 2.0,
             ),
             borderRadius: BorderRadius.circular(7.0),
           ),
           child: Padding(
             padding: const EdgeInsets.all(5.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Image.asset(
                   'assets/airtime.png',
                   height: 30,
                 ),
                 Text('Buy Airtime/Data'),
               ],



             ),
           ),

       ),
     ),
   ),
    Expanded(
      child: Container(
          height:50,
          width:50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),

          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/electricity.png',
                  height: 30,
                ),
                Text('Electricity Bill'),
              ],



            ),
          ),


      ),
    ),

  ],


),

                   ),
                   // Container()





             ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(7.0),
                      ),

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Container(
                                height:50,
                                width:50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/data.png',
                                        height: 30,
                                      ),
                                      Text('Insurance'),
                                    ],



                                  ),
                                ),

                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height:50,
                              width:50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(7.0),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/cable.png',
                                      height: 30,
                                    ),
                                    Text('Cable'),
                                  ],



                                ),
                              ),


                            ),
                          ),

                        ],


                      ),

                    ),
                    // Container()





                  ),
                ],

            ),
          ),
        ),
      ),
    );
  }
}

serviceContainer(String image,String name, int index) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.blue.withOpacity(0),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset("assets/"+image, height: 45),
          ]),
    ),
  );
}
workerContainer(String name, String job, String image, double rating) {
  return GestureDetector(
    child: AspectRatio(
      aspectRatio: 3.5,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(image)
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(job, style: TextStyle(fontSize: 15),)
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(rating.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                ],
              )
            ]
        ),
      ),
    ),
  );
}

parkingHistory(){


}
