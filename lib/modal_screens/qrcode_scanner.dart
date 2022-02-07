import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:laspa_customer/modal_screens/web_view_qrcode.dart';
import 'package:laspa_customer/shared/bottomnav.dart';


class qrcode_scanner extends StatefulWidget {
  const qrcode_scanner({Key? key}) : super(key: key);

  @override
  _qrcode_scannerState createState() => _qrcode_scannerState();
}

class _qrcode_scannerState extends State<qrcode_scanner> {
  String barcode = "";



  @override
  initState() {
    super.initState();
    scan();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Scan QR Code',
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

              // Center(
              //   child: Container(
              //     height: MediaQuery.of(context).size.height*0.50,
              //     width: double.infinity,
              //     child: Image.asset(
              //       "assets/scanimg.png",
              //       fit: BoxFit.contain,
              //       height: 200.0,
              //     ),
              //   ),
              // ),


              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              //   child: RaisedButton(
              //       color: Colors.deepOrange,
              //       textColor: Colors.white,
              //       splashColor: Colors.blueGrey,
              //       onPressed: scan,
              //       child: const Text('START CAMERA SCAN')
              //   ),
              // )
              // ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () async {

                    _handleURLButtonPress(context, barcode);

                  },
                  color: Color(0xffffcc00),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Open",
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
    );
  }
  Future scan() async {
    try {
      String barcode = (await BarcodeScanner.scan());
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
void _handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => load_Qr(url)));
}