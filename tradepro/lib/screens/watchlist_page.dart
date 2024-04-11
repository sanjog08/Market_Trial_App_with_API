import 'package:flutter/material.dart';
import 'package:tradepro/watchlist/watchlist1.dart';
import 'package:tradepro/watchlist/watchlist2.dart';
import 'package:tradepro/watchlist/watchlist3.dart';
import 'package:tradepro/watchlist/watchlist4.dart';
import 'package:tradepro/watchlist/watchlist5.dart';
import 'package:tradepro/watchlist/watchlist6.dart';
import 'package:tradepro/watchlist/watchlist7.dart';


const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);


class watchlist_appBar extends StatelessWidget implements PreferredSizeWidget{
  const watchlist_appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: clr1,
      // centerTitle: true,
      title: Text('Market Trial', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: clr2),),
      elevation: 4,
      bottom: const TabBar(
        labelColor: clr3,
        unselectedLabelColor: clr2,
        labelPadding: EdgeInsets.only(left: 20, right: 20),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        isScrollable: true,
        tabs: [
          Tab(text: 'Watchlist 1'),
          Tab(text: 'Watchlist 2',),
          Tab(text: 'Watchlist 3',),
          Tab(text: 'Watchlist 4',),
          Tab(text: 'Watchlist 5',),
          Tab(text: 'Watchlist 6',),
          Tab(text: 'Watchlist 7',),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();

}

class watchlist_tabBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: clr3,
      unselectedLabelColor: clr2,
      isScrollable: true,
      tabs: [
        Tab(text: 'Watchlist 1'),
        Tab(text: 'Watchlist 2',),
        Tab(text: 'Watchlist 3',),
        Tab(text: 'Watchlist 4',),
        Tab(text: 'Watchlist 5',),
        Tab(text: 'Watchlist 6',),
        Tab(text: 'Watchlist 7',),
      ],
    );

  }
}

class watchlist_body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        watchlist_1(),
        watchlist_2(),
        watchlist_3(),
        watchlist_4(),
        watchlist_5(),
        watchlist_6(),
        watchlist_7(),
      ],
    );
  }
}