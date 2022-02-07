import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/shared/bottomnav.dart';


class parking_areas extends StatefulWidget {
  const parking_areas({Key? key}) : super(key: key);

  @override
  _parking_areasState createState() => _parking_areasState();
}

class _parking_areasState extends State<parking_areas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffB6B6B6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,

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
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.grey.shade700,
              size: 30,
            ),
          )
        ],

      ),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
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


            // we will give media query height
            // double.infinity make it big as my parent allows
            // while MediaQuery make it big as per the screen

            width: double.infinity,
            height: MediaQuery.of(context).size.height/1.8,


            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFCC01),


                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)

                          ),

                  ),

                  child:  Center(child: Text("Free Lanes",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('2',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('20',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('40',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('13',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('2',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('20',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('40',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:() {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => parking_areas()));


                            // _onAlertWithCustomContentPressed(context);

                          },

                          child: Container(

                            height:45.0,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2.0,
                              ),
                            ),

                            child:Padding(
                              padding: const EdgeInsets.only(
                                left:5.0,
                                right:5.0,
                              ),
                              child: Column(
                                children: [
                                  Text('lane',  style: TextStyle(fontSize: 16,)),
                                  Text('13',  style: TextStyle(fontSize: 16,)),



                                ],
                              ),
                            ),

                          ),
                        ),
                      ),


                    ],
                  ),
                ),




              ],
            ),
          ),
        ),

      ),
    );
  }
}
