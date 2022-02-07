import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laspa_customer/PaymentMethod/ussd_code_generation.dart';
import 'package:laspa_customer/animation/FadeAnimation.dart';
import 'package:laspa_customer/modal_screens/parking_space.dart';
import 'package:laspa_customer/shared/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';





class cardPayment extends StatefulWidget {

 // String url = 'http://dev.prananet.io/LaspaApp/Payment/cardpayment?i=';
  final url;

  cardPayment(this.url);

  // const cardPayment({Key? key}) : super(key: key);

  @override
  _cardPaymentState createState() => _cardPaymentState(this.url);
}

class _cardPaymentState extends State<cardPayment> {

  var _url;
  final _key = UniqueKey();

  _cardPaymentState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}
