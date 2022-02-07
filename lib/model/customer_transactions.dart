import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/modal_screens/parking_area.dart';
import 'package:shared_preferences/shared_preferences.dart';



late final List<Wallet> wallet;

late String agentCode;



class Wallet {
  final String TransactionID;
  final String amount;
  final String channel;
  final String debitOrCredit;
  final String valueDate;


  Wallet({
    required this.TransactionID,
    required this.amount,
    required this.channel,
    required this.debitOrCredit,
    required this.valueDate,

  });

  factory Wallet.fromJson(Map<String, dynamic> singleUser) {
    return Wallet(

      TransactionID: singleUser["TransactionID"],
      amount: singleUser["amount"],
      channel: singleUser["channel"],
      debitOrCredit: singleUser["debitOrCredit"],
      valueDate: singleUser["valueDate"],
    );




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: wallet.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(wallet[currentIndex], context);
    },
  );
}



class customerWallet extends StatefulWidget {


  final List<Wallet> wallet;

  customerWallet(this.wallet);

  @override
  _customerWalletState createState() => _customerWalletState();
}

class _customerWalletState extends State<customerWallet> {


  void initial() async{
    var localStorage = await SharedPreferences.getInstance();
    setState((){
      agentCode = localStorage.getString('agentCode');
    });
  }
  @override

  Future getEmail()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      agentCode = localStorage.getString('agentCode');
    });
  }
  @override
  void initState() {
    super.initState();
    getEmail();
    //getRequest();
  }



  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.wallet.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.wallet[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Wallet wallet, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [

        AspectRatio(
          aspectRatio: 4.0,
          child: Padding(
            padding: const EdgeInsets.only(top:10.0,bottom:10.0,left:20.0,right:20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget> [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset('assets/Iconionic-md-cash.png', height: 20,)
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(wallet.debitOrCredit, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5),
                            Text(wallet.valueDate, style: TextStyle(fontSize: 12),)
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('N'+ wallet.amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                          ],
                        )
                      ],



                    ),



                  ],



                ),
              ),


            ),
          ),
        ),

      ],



    ),



  );

}
// class parkingArea extends StatefulWidget {
//   final String value;
//
//
//
//
//
//
//   parkingArea({Key? key, required this.value}) : super(key: key);
//
//   @override
//   _parkingAreaState createState() => _parkingAreaState();
// }
//
// class _parkingAreaState extends State<parkingArea> {
//
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   setState(() {
//   password = preferences.getString('password');
//   agentCode = preferences.getString('agentCode');
//   customerEmail = preferences.getString('email');
//   customerPhone = preferences.getString('phone');
//   });
// //  print('${widget.value.ParkingAreaID}'),
//   String test = 'yea';
//
//
//   @override
//
//
//   Widget build(BuildContext context) {
//     return Container(
//
//
//       child: Text(test),
//
//     );
//   }
// }
