import 'package:flutter/material.dart';

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);


class coming_soon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon', style: TextStyle(color: clr2),),
        backgroundColor: clr1,
        iconTheme: IconThemeData(
          color: clr2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 30.0),
        child: Center(
            child: Text("Exciting things are brewing behind the scenes! Stay tuned for the big reveal. We're working hard to bring you an amazing experience. Coming soon!", style: TextStyle(color: clr2, fontSize: 23),)
        ),
      ),
    );
  }
  
}