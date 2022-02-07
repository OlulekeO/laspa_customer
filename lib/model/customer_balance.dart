import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences localStorage;

// late String SubMarshalID;
// late String MashalID;
class Balance {
  final String WalletAmount;

  Balance ({
    required this.WalletAmount,


  });

  factory Balance.fromJson(Map<String, dynamic> jsonData) {
    return Balance (
      WalletAmount: jsonData['WalletAmount'],

    );


  }

}

late final List<Balance > balances ;


Widget build(context) {
  return ListView.builder(
    itemCount: balances.length,
    itemBuilder: (context, int currentIndex) {
      return accountBalance(balances [currentIndex], context);
    },
  );
}


class CustomListView9  extends StatefulWidget {
  final List<Balance > balances ;

  CustomListView9 (this.balances );

  @override
  State<CustomListView9 > createState() => _CustomListView9State();
}

late String SubMarshalID;

class _CustomListView9State extends State<CustomListView9> {
  // Future getEmail()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     SubMarshalID = preferences.getString('AgentCode');
  //   });
  // }





  void initial() async{
    localStorage = await SharedPreferences.getInstance();
    setState((){
      SubMarshalID = localStorage.getString('AgentCode');
      //  userEmail = localStorage.getString('Email');
    });
  }
  @override

  Future getEmail()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      SubMarshalID = localStorage.getString('AgentCode');
    });
  }


  @override
  void initState() {
    super.initState();
    getEmail();
    //getRequest();
  }
  Widget build(context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.balances.length,
      itemBuilder: (context, int currentIndex) {
        return accountBalance(widget.balances[currentIndex], context);
      },
    );
  }
}

Widget accountBalance(Balance balance, BuildContext context) {
  return ListTile(
      title: Column(
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text('₦ ' + balance.WalletAmount,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),




        ],
      ),
      onTap: () {

        // var route = new MaterialPageRoute(
        //   builder: (BuildContext context) =>
        //   new reportDetails(value: spacecraft),
        // );
        // Navigator.of(context).push(route);

      });

}



//Future is n object representing a delayed computation.


