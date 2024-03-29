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



late final List<Parking> parking;

late String agentCode;



class Parking {
  final String ParkingID;
  final String ContactID;
  final String Amount;
  final String PlateNumber;
  final String ParkingTime;
  final String ParkingHour;
  final String Parkingstatus;
  final String ParkingAreaID;
  final String ParkingSpotID;
  final String ParkingAreaName;
  final String ExpiringTime;
  final String channel;
  final String Location;
  final String qrcode;
  final String ParkingSpotName;



  Parking({
    required this.ParkingID,
    required this.ContactID,
    required this.Amount,
    required this.PlateNumber,
    required this.ParkingTime,
    required this.ParkingHour,
    required this.Parkingstatus,
    required this.ParkingAreaID,
    required this.ParkingSpotID,
    required this.ParkingAreaName,
    required this.ExpiringTime,
    required this.channel,
    required this.Location,
    required this.qrcode,
    required this.ParkingSpotName,


  });

  factory Parking.fromJson(Map<String, dynamic> singleUser) {
    return Parking(

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
      ExpiringTime: singleUser["ExpiringTime"],
      channel: singleUser["channel"],
      Location: singleUser["Location"],
      ParkingSpotName: singleUser["ParkingSpotName"],

      qrcode: "https://app.prananet.io/LaspaApp/Qrcode/"+singleUser["Qrimage"],

    );




  }


}



Widget build(context) {
  return ListView.builder(
    itemCount: parking.length,
    itemBuilder: (context, int currentIndex) {
      return createUserView(parking[currentIndex], context);
    },
  );
}



class customerParkingTransactionsAll extends StatefulWidget {


  final List<Parking> parking;

  customerParkingTransactionsAll(this.parking);

  @override
  _customerParkingTransactionsAllState createState() => _customerParkingTransactionsAllState();
}

class _customerParkingTransactionsAllState extends State<customerParkingTransactionsAll> {


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
      itemCount: widget.parking.length,
      itemBuilder: (context, int currentIndex) {
        return createUserView(widget.parking[currentIndex], context);
      },
    );
  }


}


Widget createUserView(Parking parking, BuildContext context) {
  return ListTile(

    title: Column(


      children: <Widget> [


        GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  reportDetails(value: parking),
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
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset('assets/Iconionic-md-cash.png', height: 20,)
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(parking.ParkingAreaName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              SizedBox(height: 3),
                              Text(parking.PlateNumber, style: TextStyle(fontSize: 15),),

                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('₦ ' + parking.Amount.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                            ],
                          )
                        ],



                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(parking.ParkingTime, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,),)),
                          ),




                          if (parking.Parkingstatus == '1') ...[
                            const Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('current', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.green,),)),
                            ),

                          ]else if(parking.Parkingstatus == '2') ...[
                            const Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Checkout', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.orange, ),)),
                            ),

                          ]

                          else ...[
                              Expanded(
                                child: Container(

                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('Cancelled', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red,),)),


                                ),
                              ),
                            ],


                        ],


                      ),

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
  final Parking value;
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
              "Parking Ticket",
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
                  Text("Receipt",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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

                  DottedBorder(
                    borderType: BorderType.RRect,
                    // radius: Radius.circular(12),
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),


                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),

                        width: double.infinity,
                        child: Column(


                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/LASPAo.png",
                                  height: 70,
                                ),
                                Text(
                                  datetime3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                                ),



                              ],


                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //           Container(
                                //           decoration: BoxDecoration(
                                //               image: new DecorationImage(
                                //               image: new NetworkImage('https://app.prananet.io/LaspaApp/Qrcode/qrcodes/005_file_368a9662346859dd223d409b50fcef8d.png'),
                                //     ),
                                //   ),
                                // ),

                                Column(

                                  children: [



                                    Text(widget.value.ParkingAreaName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.0)),


                                    Image.network(
                                      widget.value.qrcode,
                                      height: 100,
                                    ),

                                    // CachedNetworkImage(
                                    //   progressIndicatorBuilder: (context, url, progress) => Center(
                                    //     child: CircularProgressIndicator(
                                    //       value: progress.progress,
                                    //     ),
                                    //   ),
                                    //   imageUrl:
                                    //   codeLink,
                                    //   height: 100,
                                    // ),

                                  ],



                                ),



                                // Image(
                                //   image: message != null ? NetworkImage(message) : null,
                                //   width: 200,
                                // ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(

                                      left: 20,
                                    ),
                                    child: Column(

                                      children: [

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Platenumber: "+ widget.value.PlateNumber,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0)),
                                        ),


                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Parking spot: "+ widget.value.ParkingSpotName,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Amount: ""₦ "+ widget.value.Amount,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0)),



                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Park Time: "+ widget.value.ParkingTime,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("End Time: "+ widget.value.ExpiringTime,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0)),




                                      ],


                                    ),
                                  ),
                                ),


                                // Text(
                                //   ' Wasiu',
                                //   style: TextStyle(color: Colors.black, fontSize: 16.0),
                                // ),



                              ],


                            ),

                            // Image.network(
                            //   codeLink,
                            //   height: 100,
                            // ),


                          ],
                        ),

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
                              if(_formKey.currentState!.validate()){
                                setState(() => loading = true);

                                // notifyCustomer();
                              }



                              //Navigator.push(context, MaterialPageRoute(builder: (context) => agent_verification_result()));
                            },
                            color: Color(0xffffcc00),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Cancel Booking" ,
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
