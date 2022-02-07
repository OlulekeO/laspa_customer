import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/Notification/customer_alert_all.dart';
import 'package:laspa_customer/PaymentMethod/card_payment.dart';
import 'package:laspa_customer/PaymentMethod/ussd_payment.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/model/customer_transactions.dart';
import 'package:laspa_customer/model/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';


final _links = 'https://app.prananet.io/LaspaApp/Payment/cardpayment?i=';



class customer_wallet extends StatefulWidget {
  const customer_wallet({Key? key}) : super(key: key);

  @override
  _customer_walletState createState() => _customer_walletState();
}



String url = 'https://app.prananet.io/LaspaApp/Payment/cardpayment?i=';

String rightUrl = url;

class _customer_walletState extends State<customer_wallet> {

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






  Future<List<Wallet>> customerWalletGet() async {


    String url = "https://app.prananet.io/LaspaApp/Api/customer_wallet_transactions";
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
    List<Wallet> wallets = [];
    for (var singleUser in responseData) {
      Wallet wallet = Wallet(
        TransactionID: singleUser["TransactionID"],
        amount: singleUser["amount"],
        channel: singleUser["channel"],
        debitOrCredit: singleUser["debitOrCredit"],
        valueDate: singleUser["valueDate"]
      );

      //Adding user to the list.
      wallets.add(wallet);

    }
    return wallets;

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
          title: Text(
            'Transactions',
            style: TextStyle(color: Colors.black),
          ),
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


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height*0.20,
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


                    child: Column(

                      children: [

                        FadeAnimation(
                          1.2,
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
                                      child: GestureDetector(
                                        onTap:() {

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => payment_ussd()));


                                          // _onAlertWithCustomContentPressed(context);

                                        },
                                        child: Container(
                                          height:50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFF4C6),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/paywithcash.png',
                                                  height: 20,
                                                ),
                                                SizedBox(width: 20,),
                                                Text('Top-up with USSD'),
                                              ],



                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),


                                ],


                              ),

                            ),
                            // Container()





                          ),
                        ),

                        FadeAnimation(
                          1.2,
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
                                      child: GestureDetector(
                                        onTap: () => _handleURLButtonPress(context, _links),
                                        child: Container(
                                          height:50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFF4C6),
                                            border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/paywithcard.png',
                                                  height: 20,
                                                ),
                                                SizedBox(width: 20,),
                                                Text('Top-up with card'),
                                              ],



                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),


                                ],


                              ),

                            ),
                            // Container()





                          ),
                        ),


                      ],

                    ),





                  ),
                ),
              ),




              SizedBox(height: 10,),






              FutureBuilder<List<Wallet>>(
                future: customerWalletGet(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<Wallet>? wallet = snapshot.data;
                    return customerWallet(wallet!);
                  } else if (snapshot.hasError) {
                    // return Text('${snapshot.error}');
                    return Center(child: Text('No Transactions yet'));
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