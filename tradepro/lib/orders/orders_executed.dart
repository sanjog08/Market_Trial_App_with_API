import 'package:flutter/material.dart';

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class executed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 30.0),
      child: Center(
          child: Container(
            child: Text("In this section in TradeTrial app lists completed orders showing details of bought or sold stocks/assets that have been successfully processed or filled.", style: TextStyle(color: clr2, fontSize: 23),),
          )
      ),
    );
  }

}