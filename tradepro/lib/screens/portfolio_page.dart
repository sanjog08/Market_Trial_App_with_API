import 'package:flutter/material.dart';
import 'package:tradepro/portfolio/portfolio_holdings.dart';
import 'package:tradepro/portfolio/portfolio_positions.dart';


const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class porfolio_appBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: clr1,
      // centerTitle: true,
      title: Text('Portfolio', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: clr2),),
      elevation: 4,
      bottom: TabBar(
        labelColor: clr3,
        unselectedLabelColor: clr2,
        labelPadding: EdgeInsets.only(left: 40, right: 40),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        isScrollable: true,
        tabs: [
          Tab(text: 'Holdings'),
          Tab(text: 'Positions',),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}

class portfolio_body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: [
          holdings(),
          positions(),
        ]
    );
  }

}