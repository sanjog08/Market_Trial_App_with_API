import 'package:flutter/material.dart';
import 'package:tradepro/watchlist/watchlist3.dart';
import 'package:tradepro/watchlist/watchlist4.dart';
import 'package:tradepro/watchlist/watchlist5.dart';

// class tool extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: const TabBar(
//               tabs: [
//                 Tab(text: 'Basteks',),
//                 Tab(text: 'SIPs',),
//                 Tab(text: 'Alerts',),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class tools_appBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: clr1,
      // centerTitle: true,
      title: Text('Tools', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: clr2),),
      elevation: 4,
      bottom: TabBar(
        labelColor: clr3,
        unselectedLabelColor: clr2,
        labelPadding: EdgeInsets.only(left: 30, right: 30),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        isScrollable: true,
        tabs: [
          Tab(text: 'Basckets'),
          Tab(text: 'SIP',),
          Tab(text: 'Alerts',),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}


class tools_body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: [
          watchlist_3(),
          watchlist_3(),
          watchlist_3(),
        ]
    );
  }

}