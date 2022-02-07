
import 'package:flutter/material.dart';
import 'package:laspa_customer/HomePage/dashboard.dart';
import 'package:laspa_customer/Profile/customer_profile.dart';
import 'package:laspa_customer/Support/customer_support.dart';
import 'package:laspa_customer/Transactions/wallet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    dashboard(),
    customer_wallet(),
    customer_support(),
    customer_profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Color(0xFF000000),),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Iconawesome-wallet.png"),
              color: Color(0xFF000000),
            ),
            title: Text('Wallet'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Iconmaterial-headset-mic.png"),
              color: Color(0xFF000000),
            ),
            title: Text('Support'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/Iconfeather-users.png"),
              color: Color(0xFF000000),
            ),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:Color(0xffFFDD4F),
        onTap: _onItemTapped,
      ),
    );
  }
}