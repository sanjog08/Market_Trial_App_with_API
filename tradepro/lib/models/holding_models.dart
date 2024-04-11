// To parse this JSON data, do
//
//     final holdingModel = holdingModelFromJson(jsonString);

import 'dart:convert';

HoldingModel holdingModelFromJson(String str) => HoldingModel.fromJson(json.decode(str));

String holdingModelToJson(HoldingModel data) => json.encode(data.toJson());

class HoldingModel {
  String id;
  String stockName;
  double rate;
  String se;
  int quantity;

  HoldingModel({
    required this.id,
    required this.stockName,
    required this.rate,
    required this.se,
    required this.quantity,
  });

  factory HoldingModel.fromJson(Map<String, dynamic> json) => HoldingModel(
    id: json["_id"],
    stockName: json["stock_name"],
    rate: json["rate"]?.toDouble(),
    se: json["se"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "stock_name": stockName,
    "rate": rate,
    "se": se,
    "quantity": quantity,
  };
}
