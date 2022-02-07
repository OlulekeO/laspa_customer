import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/modal_screens/parking_area.dart';
import 'package:shared_preferences/shared_preferences.dart';



late final List<CustomerNotification> _notification;

late String agentCode;



class CustomerNotification {
  final String NotificationID;
  final String Title;
  final String Body;
  final String NotificationStatus;
  final String DateCreated;
  final String ReceiverType;



  CustomerNotification({
    required this.NotificationID,
    required this.Title,
    required this.Body,
    required this.NotificationStatus,
    required this.DateCreated,
    required this.ReceiverType,

  });

  factory CustomerNotification.fromJson(Map<String, dynamic> singleUser) {
    return CustomerNotification(

      NotificationID: singleUser["NotificationID"],
      Title: singleUser["Title"],
      Body: singleUser["Body"],
      NotificationStatus: singleUser["NotificationStatus"],
      DateCreated: singleUser["DateCreated"],
      ReceiverType: singleUser["ReceiverType"],
    );




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: _notification.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(_notification[currentIndex], context);
    },
  );
}




class customerNotification extends StatefulWidget {


  final List<CustomerNotification> _notification;

  customerNotification(this._notification);

  @override
  _customerNotificationState createState() => _customerNotificationState();
}

class _customerNotificationState extends State<customerNotification> {


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
      itemCount: widget._notification.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget._notification[currentIndex], context);
      },
    );
  }


}


Widget createUserView(CustomerNotification _notification, BuildContext context) {
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
                        Icon(
                        Icons.notifications_none,
                        color: Colors.grey.shade700,
                        size: 30,
                      ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_notification.Title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5),
                            Text(_notification.Body, style: TextStyle(fontSize: 12),)
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('N'+ _notification.DateCreated, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
