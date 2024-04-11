import 'package:flutter/material.dart';

class positions extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var arrStocks = [
      'TRIDENT',
      'EXIDEIND',
      'MINDACORP',
      'SJVN'
    ];
    var arrSE = [
      'BSE',
      'BSE',
      'NSE',
      'NSE'
    ];
    var arrColor = [
      Colors.green,
      Colors.green,
      Colors.red,
      Colors.green
    ];
    var arrRate = [
      '-3.10 (-1.94%)',
      '-4.55 (-1.61%)',
      '-3.45 (-0.87%)',
      '+0.45 (+0.60%)'
    ];
    var arrRateSt = [
      '102.45',
      '277.85',
      '391.85',
      '75.35'
    ];

    return ListView.separated(itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(flex: 3,
                child: Container(
                    margin: EdgeInsets.only(left: 15), child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(arrStocks[index], style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500, color: Color(
                        0xFF424242))),
                    Text(arrSE[index], style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500, color: Color(
                        0xFF424242))),

                  ],
                ))),
            Expanded(flex: 2,
                child: Container(
                    margin: EdgeInsets.only(right: 12), child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(arrRateSt[index], style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: arrColor[index])),
                    Text(arrRate[index], style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400, color: Color(
                        0xFF757575))),
                  ],
                ))),
          ],
        ),
      );
    },
      itemCount: arrStocks.length,
      separatorBuilder: (context, index) {
        return Divider(height: 6,);
      },
    );
  }

}