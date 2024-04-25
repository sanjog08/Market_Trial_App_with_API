import 'dart:convert';

AllStocksModel allStocksModelFromJson(String str) => AllStocksModel.fromJson(json.decode(str));

String allStocksModelToJson(AllStocksModel data) => json.encode(data.toJson());

class AllStocksModel {
  String id;
  String stockName;
  String companyName;
  num rate;

  AllStocksModel({
    required this.id,
    required this.stockName,
    required this.companyName,
    required this.rate,
  });

  factory AllStocksModel.fromJson(Map<String, dynamic> json) => AllStocksModel(
    id: json["_id"],
    stockName: json["stock_name"],
    companyName: json["company_name"],
    rate: json["rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "stock_name": stockName,
    "company_name": companyName,
    "rate": rate,
  };
}


// url variable for all wi-fi's
const mobile = '192.168.66.175';
const home = '192.168.29.117';
const hostel = '192.168.1.12';
const _vercel = 'deployed-stock-api.vercel.app';

// switch url IP-address from here
const wifi = _vercel;
// update this wifi on your presence