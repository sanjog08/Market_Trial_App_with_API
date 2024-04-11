import 'package:flutter/material.dart';

const Color clr1 = Color(0xFFEEEEEE);
const Color clr2 = Color(0xFF616161);
const Color clr3 = Color(0xFF2196F3);

class auctions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 30.0),
      child: Center(
          child: Container(
            child: Text("The Auctions section in TradeTrial app displays orders placed in the auction market, showing bids and offers for securities that are being auctioned due to specific market conditions.", style: TextStyle(color: clr2, fontSize: 23),),
          )
      ),
    );
  }

}