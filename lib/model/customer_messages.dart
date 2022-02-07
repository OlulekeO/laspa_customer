import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/modal_screens/parking_area.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:laspa_customer/shared/bottomnav.dart';


late final List<AlertMessage> alertmessage;

late String agentCode;



class AlertMessage {
  final String NotificationID;
  final String Title;
  final String Body;
  final String NotificationStatus;
  final String DateCreated;
  final String ReceiverType;




  AlertMessage({
    required this.NotificationID,
    required this.Title,
    required this.Body,
    required this.NotificationStatus,
    required this.DateCreated,
    required this.ReceiverType,


  });

  factory AlertMessage.fromJson(Map<String, dynamic> singleUser) {
    return AlertMessage(

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
    itemCount: alertmessage.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(alertmessage[currentIndex], context);
    },
  );
}



class customerAlert extends StatefulWidget {


  final List<AlertMessage> alertmessage;

  customerAlert(this.alertmessage);

  @override
  _customerAlertState createState() => _customerAlertState();
}

class _customerAlertState extends State<customerAlert> {


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
      itemCount: widget.alertmessage.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.alertmessage[currentIndex], context);
      },
    );
  }


}


Widget createUserView(AlertMessage alertmessage, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [


        GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  reportDetails(value: alertmessage),
            );
            Navigator.of(context).push(route);

          },

          child: AspectRatio(
            aspectRatio: 9/ 3,
            child: Padding(
              padding: const EdgeInsets.only(top:5.0,bottom:0.0,left:10.0,right:10.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
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
                              Text(alertmessage.Title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              SizedBox(height: 3),
                              FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(alertmessage.Body, style: TextStyle(fontSize: 14),)),

                            ],
                          ),
                          Spacer(),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(alertmessage.DateCreated.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                          //     SizedBox(height: 5,),
                          //   ],
                          // )
                        ],



                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //
                      //     Expanded(
                      //       child: Align(
                      //           alignment: Alignment.topLeft,
                      //           child: Text(alertmessage.DateCreated, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,),)),
                      //     ),
                      //
                      //
                      //
                      //     //
                      //     // if (alertmessage.NotificationStatus == '1') ...[
                      //     //   const Expanded(
                      //     //     child: Align(
                      //     //         alignment: Alignment.centerRight,
                      //     //         child: Text('current', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.green,),)),
                      //     //   ),
                      //     //
                      //     // ]else if(alertmessage.NotificationStatus == '2') ...[
                      //     //   const Expanded(
                      //     //     child: Align(
                      //     //         alignment: Alignment.centerRight,
                      //     //         child: Text('Checkout', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.orange, ),)),
                      //     //   ),
                      //     //
                      //     // ]
                      //     //
                      //     // else ...[
                      //     //     Expanded(
                      //     //       child: Container(
                      //     //
                      //     //         child: Align(
                      //     //             alignment: Alignment.centerRight,
                      //     //             child: Text('Cancelled', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red,),)),
                      //     //
                      //     //
                      //     //       ),
                      //     //     ),
                      //     //   ],
                      //
                      //
                      //   ],
                      //
                      //
                      // ),

                    ],



                  ),
                ),


              ),
            ),
          ),
        ),


      ],



    ),



  );

}

class reportDetails extends StatefulWidget {
  final AlertMessage value;
  // const reportDetails({Key? key,this.value}) : super(key: key);
  const reportDetails({Key? key, required this.value}) : super(key: key);

  @override
  _reportDetailsState createState() => _reportDetailsState();
}

DateTime datetime = DateTime.now();

class _reportDetailsState extends State<reportDetails> {

  String datetime3 = DateFormat.MMMMEEEEd().format(datetime);

  String? request;



  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String btn = '';

  String isMorning = '';







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8D8D8),
      appBar: AppBar(
        backgroundColor: Color(0xffffcc00),
        centerTitle: false,
        title: const Center(
            child: Text(
              "Notification Information",
              style: TextStyle(
                color: Color(0xff000000),
              ),
            )),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
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
            // height: MediaQuery.of(context).size.height/2.0,
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form(
              key:  _formKey,
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Notification",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  //   Text("Preview",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      height: 90,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 90,
                        child: Image.asset(
                          "assets/sucessful.png",
                          height: 50,
                        ),
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),


                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),

                      width: double.infinity,
                      child: Column(


                        children: [


                          Text(widget.value.Title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0)),


                          const SizedBox(
                            height: 10,
                          ),

                          Text(widget.value.Body,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0)),


                          // Image.network(
                          //   codeLink,
                          //   height: 100,
                          // ),


                        ],
                      ),

                    ),
                  ),


                  const SizedBox(
                    height: 30,
                  ),




                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: MaterialButton(
                      //       minWidth: double.infinity,
                      //       height: 40,
                      //       onPressed: () async {
                      //
                      //
                      //
                      //         // Navigator.push(context, MaterialPageRoute(builder: (context) => landingPage()));
                      //       },
                      //       color: Color(0xfffffffff),
                      //       elevation: 0,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       child: const Text(
                      //         "Cancel" ,
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 18,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      Expanded(
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => MyApp()));


                              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                            },
                            color: Color(0xffffcc00),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Dismiss" ,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),



                    ],




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
