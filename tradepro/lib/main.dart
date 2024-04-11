import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tradepro/screens/orders_page.dart';
import 'package:tradepro/screens/profile_page.dart';
import 'package:tradepro/screens/portfolio_page.dart';
import 'package:tradepro/screens/tools_page.dart';
import 'package:tradepro/screens/watchlist_page.dart';
import 'package:tradepro/splash_screeen.dart';

void main(){
  runApp(MyApp());
}

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Viewer' ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Color(0xFFEEEEEE),
      ),
      home: SplashScreen(),
    );
  }
}

class zerodha_clone extends StatefulWidget{
  const zerodha_clone({super.key});

  @override
  State<zerodha_clone> createState() => _Zerodha_cloneState();
}

class _Zerodha_cloneState extends State<zerodha_clone> {

  int _selectedIndex = 0;
  final List<int> _tabControllerLenght = [7, 5, 2, 3, 1];
  static List _appBarWidgetOptions = [
    watchlist_appBar(),
    orders_appBar(),
    porfolio_appBar(),
    tools_appBar(),
    profile_appBar(),
  ];
  static List _bodyWidgetOptions = [
    watchlist_body(),
    orders_body(),
    portfolio_body(),
    tools_body(),
    profile_body(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: _tabControllerLenght.elementAt(_selectedIndex),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus){
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(90.0),
                child: _appBarWidgetOptions.elementAt(_selectedIndex),
            ),
            body: _bodyWidgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Watchlist'),
                BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: 'Orders'),
                BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined), label: 'Portfolio'),
                BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: 'Tools'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
              selectedItemColor: clr3,
              unselectedItemColor: clr2,
              backgroundColor: clr1,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}