// Alert custom content leke
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


final _formKey = GlobalKey<FormState>();
bool loading = false;

String ussdbank = '';
String ussdplatenumber = '';
String ussdamount = '';



_onAlertWithCustomContentPressed(context) {
  Alert(
    context: context,
    title: "USSD Code",
    buttons: [],
    content: Form(
      key:  _formKey,
      child: Column(
        children: <Widget>[
          TextField(
            onChanged :(val){
              setState(() => ussdbank = val);
            },
            decoration: InputDecoration(
              // icon: Icon(Icons.account_circle),
              labelText: 'Bank',
            ),
          ),
          TextField(
            onChanged :(val){
              setState(() => ussdplatenumber = val);
            },
            decoration: InputDecoration(
              // icon: Icon(Icons.account_circle),
              labelText: 'PlateNumber',
            ),
          ),
          TextField(
            onChanged :(val){
              setState(() => ussdamount = val);
            },
            decoration: InputDecoration(
              // icon: Icon(Icons.account_circle),
              labelText: 'Amount',
            ),
          ),
          // TextField(
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     // icon: Icon(Icons.lock),
          //     labelText: 'Duration',
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                ' *737*2*1000',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              MaterialButton(
                // minWidth: double.infinity,
                height: 30,
                color: Color(0xffffcc00),
                onPressed: () {
                 // paywithussd();

                 // Codegenerate();
                  // String message = "Ussd code on its way";
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: new Text(GeneratedUSSDCode),
                  //       actions: <Widget>[
                  //         FlatButton(
                  //           child: new Text(GeneratedUSSDCode),
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );


                },
                // defining the shape
                shape: RoundedRectangleBorder(

                  // side: BorderSide(
                  //     color: Colors.black
                  // ),
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "PushLink",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ).show();
}

void setState(String Function() param0) {
}