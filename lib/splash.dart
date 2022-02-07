import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/scroll.dart';


class splash_Screen extends StatefulWidget {
  const splash_Screen({Key? key}) : super(key: key);

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 5),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => get_Started() ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8D8D8),
      body: Stack(

        children: <Widget>[
         Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/laspaBgoverlay.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image(
              //   image: AssetImage("assets/LASPALOGOPNGB.png"),
              //   height: 400,
              // ),

        ),
              Center(
                child: Image(image:const AssetImage("assets/LASPAInvert.png",

                ),
                ),
              ),
      ],
    ),
    );
  }
}
