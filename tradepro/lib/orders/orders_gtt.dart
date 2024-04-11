import 'package:flutter/material.dart';

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class gtt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 30.0),
      child: Center(
          child: Container(
            child: Text("The GTT (Good Till Triggered) section in TradeTrial app allows setting buy/sell orders at specified conditions, executing trades automatically when conditions are met, even when the app is closed.", style: TextStyle(color: clr2, fontSize: 23),),
          )
      ),
    );
  }

}