import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';


class code_generation extends StatefulWidget {
  const code_generation({Key? key}) : super(key: key);

  @override
  _code_generationState createState() => _code_generationState();
}

class _code_generationState extends State<code_generation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String ussdcode='';

  Future code()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      ussdcode = preferences.getString('ussdcode');
      // customerPhone = preferences.getString('phone');
    });
  }




  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: ussdcode));
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override

  void initState() {
    super.initState();
    code();
  }

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
          icon: Icon(
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
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: (){

                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => MyApp()));

                      },
                      child: Image.asset(
                        'assets/Icon ionic-md-close-circle-outline.png',
                        height: 20,
                        color: Colors.red,
                      ),
                    ),

                    Center(child: Text("USSD",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)), Text("",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),


                  ],

                ),

               const SizedBox(
                  height: 40,
                ),
          Center(child: Text('Dial the code below to complete with your Bank')),
                const SizedBox(
                  height: 20,
                ),

                Text(
                  ussdcode,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),




                const SizedBox(
                  height: 20,
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () async {

                      Clipboard.setData(ClipboardData(text: ussdcode));
                      final snackBar = SnackBar(
                        content: const Text('Copied'),
                        action: SnackBarAction(
                          label: 'Done',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    color: Color(0xffffcc00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Copy",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
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
