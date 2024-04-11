import 'package:flutter/material.dart';
import 'package:tradepro/main.dart';
import 'package:tradepro/orders/orders_auctions.dart';
import 'package:tradepro/orders/orders_executed.dart';
import 'package:tradepro/orders/orders_gtt.dart';
import 'package:tradepro/orders/orders_ipo.dart';
import 'package:tradepro/orders/orders_open.dart';
import 'package:tradepro/screens/portfolio_page.dart';
import 'package:tradepro/screens/profile_page.dart';
import 'package:tradepro/screens/tools_page.dart';
import 'package:tradepro/screens/watchlist_page.dart';
import 'package:tradepro/watchlist/watchlist1.dart';
import 'package:tradepro/watchlist/watchlist2.dart';
import 'package:tradepro/watchlist/watchlist3.dart';
import 'package:tradepro/watchlist/watchlist4.dart';
import 'package:tradepro/watchlist/watchlist5.dart';


const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class orders_appBar extends StatelessWidget implements PreferredSizeWidget{
  const orders_appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: clr1,
      // centerTitle: true,
      title: Text('Orders', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: clr2),),
      elevation: 4,
      bottom: TabBar(
        labelColor: clr3,
        unselectedLabelColor: clr2,
        labelPadding: EdgeInsets.only(left: 20, right: 20),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        isScrollable: true,
        tabs: [
          Tab(text: 'Open'),
          Tab(text: 'Executed',),
          Tab(text: 'GTT',),
          Tab(text: 'IPO',),
          Tab(text: 'Auctions',),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}

class orders_body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        open(),
        executed(),
        gtt(),
        ipo(),
        auctions(),
      ],
    );
  }

}