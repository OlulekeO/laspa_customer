import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/login.dart';
import 'Authentication/register.dart';
String customerEmail ='';
class get_Started extends StatefulWidget {
  const get_Started({Key? key}) : super(key: key);

  @override
  _get_StartedState createState() => _get_StartedState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  customerEmail = localStorage.getString('email');
  print(customerEmail);

  if (customerEmail !=''){
    MyApp();

  }else{
    customer_login();

  }

}

class _get_StartedState extends State<get_Started> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffD8D8D8),
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.50,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/Scanqr.png",
                    fit: BoxFit.contain,
                    height: 200.0,
                  ),
                ),
              ),


              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(

                    minWidth: double.infinity,
                    height: 60,
                    color: Color(0xffffcc00),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => customer_login()));


                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(


                      // side: BorderSide(
                      //     color: Colors.black
                      // ),
                        borderRadius: BorderRadius.circular(20)

                    ),
                    child: Text(

                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,

                      ),
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(

                    minWidth: double.infinity,
                    height: 60,
                    color: Color(0xffffcc00),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => customerRegistration()));

                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(


                      // side: BorderSide(
                      //     color: Colors.black
                      // ),
                        borderRadius: BorderRadius.circular(20)

                    ),
                    child: Text(

                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,

                      ),
                    ),
                  ),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
