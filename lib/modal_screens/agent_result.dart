import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/model/enforcement_marshal_profile.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class agent_verification_result extends StatefulWidget {
  const agent_verification_result({Key? key}) : super(key: key);

  @override
  _agent_verification_resultState createState() => _agent_verification_resultState();
}

class _agent_verification_resultState extends State<agent_verification_result> {


  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String agentCode = '';

  String complaint = '';


  String customerEmail = '';
  String password = '';
  String customerPhone = '';


  Future getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      password = preferences.getString('password');
      agentCode = preferences.getString('agentCode');
      customerEmail = preferences.getString('email');
      customerPhone = preferences.getString('phone');
    });
  }


  Future<List<Enforcement>> getEnforcementProfile() async {


    String url = "https://app.prananet.io/LaspaApp/Api/enforcement_marshal_getprofile";
    final response = await http.post(url, body: {
      "enforcementcode": agentCode,
    });

    var responseData = json.decode(response.body);
    // print(responseData);
    // Map message = jsonDecode(responseData);
    // String name = message['firstname'];
    // print (name);

    // Creating a list to store input data;
    List<Enforcement> enforcements = [];
    for (var singleUser in responseData) {
      Enforcement enforcement = Enforcement(
          EnforcementMarshalID: singleUser["EnforcementMarshalID"],
          EnforcementCode: singleUser["EnforcementCode"],
          FirstName: singleUser["FirstName"],
          LastName: singleUser["LastName"],
          Email: singleUser["Email"],
          Phonenumber: singleUser["Phonenumber"],
          Location: singleUser["Location"],
          CityName: singleUser["CityName"],
          ParkingArea: singleUser["ParkingArea"],
          PictureUrl: "https://app.prananet.io/LaspaApp/ProfilePicture/"+singleUser["PictureUrl"]
      );

      //Adding user to the list.
      enforcements.add(enforcement);

    }
    return enforcements;

  }



  Future <String>  agentComplaintCreate() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    String url = "https://app.prananet.io/LaspaApp/Api/enforcement_marshal_complaint_Create";
    final response = await http.post(url, body: {
      "enforcementcode": agentCode,
      "complaint": complaint,
      "email": customerEmail,
    });
    String responseData = json.encode(response.body);
    String message = json.decode(responseData);
   // print(message);



    if(message.contains("Successful")){
      setState(() {
      });
      String message = "Complaint Submitted Successfully!!";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => agent_verification_result()));


    }
    else{
      setState(() {
      });
      String message = "Marshal does not exist!!";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return message;
  }



  @override
  void initState() {
    super.initState();
    getEmail();

    getEnforcementProfile();
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
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              // constraints: BoxConstraints(
              //   maxHeight: double.infinity,
              // ),
              decoration: BoxDecoration(
                color: Color(0xffF7F7F9),
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
              // height: MediaQuery.of(context).size.height/1.4,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key:  _formKey,
                child: Column(
                  // even space distribution
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Agent Verification",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 40,
                    ),




                    FutureBuilder<List<Enforcement>>(
                      future: getEnforcementProfile(),
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          List<Enforcement>? enforcement = snapshot.data;
                          return enforcementProfile(enforcement!);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                          return Text('No Report Yet');
                        }
                        //return  a circular progress indicator.
                        return Text('');


                      },


                    ),





                    SizedBox(
                      height: 5,
                    ),
                    FadeAnimation(1.3, Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 10.0,top:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Report an issue', style: TextStyle(fontSize: 10),),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text('View all',)
                          // )
                        ],
                      ),
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onChanged :(val){

                        setState(() => complaint = val);
                      },
                      decoration: const InputDecoration(


                        fillColor: Color(0xffffffff),
                        filled: true,

                      ),

                      minLines: 4, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () async {

                          if(_formKey.currentState!.validate()){
                            setState(() => loading = true);

                            agentComplaintCreate();
                          }

                        },
                        color: Color(0xffffcc00),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Submit",
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
        ),

      ),
    );
  }
}
