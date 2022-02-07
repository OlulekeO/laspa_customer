import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/Notification/customer_alert_all.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';



class customer_support extends StatefulWidget {
  const customer_support({Key? key}) : super(key: key);

  @override
  _customer_supportState createState() => _customer_supportState();
}

class _customer_supportState extends State<customer_support> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => (true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Support',
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                // we will give media query height
                // double.infinity make it big as my parent allows
                // while MediaQuery make it big as per the screen

                width: double.infinity,
                // height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[



                        // RaisedButton(
                        //   onPressed: (){
                        //     _showSimpleModalDialog(context);
                        //   },
                        //   child: Text('Simple Dialog Modal'),
                        // ),
                        Container(
                          height: 60,
                          // color: Color(0xffffffff),

                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),


                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [

                                  Text(
                                    "Customer care",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),

                                  Icon(
                                    Icons.arrow_drop_down_circle_sharp,
                                    color: Color(0xffD8D8D8),
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 60,
                          // color: Color(0xffffffff),

                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [

                                Text(
                                  "Support Ticket",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),

                                Icon(
                                  Icons.arrow_drop_down_circle_sharp,
                                  color: Color(0xffD8D8D8),
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),

                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 60,
                          // color: Color(0xffffffff),

                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [

                                Text(
                                  "FAQ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),

                                Icon(
                                  Icons.arrow_drop_down_circle_sharp,
                                  color: Color(0xffD8D8D8),
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),

                        ),




                      ],
                    ),
                    // Container(
                    //   height:500,
                    //   width: double.infinity,
                    //   // height: MediaQuery.of(context).sizse.height / 3,
                    //   decoration: BoxDecoration(
                    //
                    //       image: new DecorationImage(
                    //         image: AssetImage("assets/LASPAo.png"),
                    //         // fit: BoxFit.cover
                    //
                    //       )
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
