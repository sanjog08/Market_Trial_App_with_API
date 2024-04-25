import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradepro/models/holding_models.dart';
import '../models/allstocks.dart';
import 'package:http/http.dart' as http;


// this is the function to retreve stocks data for any watchlist dynamically
Future<List<AllStocksModel?>> getData( List<AllStocksModel?> watchlist_stocks, int page ) async {
  final call_API = "http://$wifi/getwatchlist_$page";
  final response = await http.get(Uri.parse(call_API));
  var data =  jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    // ensure clear list while fetching data form the server
    watchlist_stocks.clear();
    for (Map<String, dynamic> index in data) {
      watchlist_stocks.add(AllStocksModel.fromJson(index));
    }
    return watchlist_stocks;
  }
  else {
    return [];
  }
}

// to update real time stock rate
void updateRate(int page) async {
  try {
    final response = await http.get(Uri.parse('http://$wifi/reload-$page'));
    if (response.statusCode == 200) {
      // Handle the successful response here
      print('Data fetched successfully');
    } else {
      // Handle the error response
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any exceptions
    print('Error fetching data: $error');
  }
}

// this is the delete function for the stock got deleted from the any watchlist dynamically
Future<void> deleteStock(String id, int page ) async {
  final call_API = "http://$wifi/delwatchlist_$page/$id";
  try {
    final response = await http.delete(Uri.parse(call_API));
    if (response.statusCode == 200) {
      print('Item deleted successfully');
    } else {
      print('Failed to delete item. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error deleting item: $e');
  }
}


// TextEditingController stock_nameController = TextEditingController();
// TextEditingController rateController = TextEditingController();


// this is a dailog widget to buy stocks from any watchlist
class DailogWidget extends StatefulWidget {
  int i;
  List<AllStocksModel?> dialog_stock = [];
  DailogWidget(this.i, this.dialog_stock);

  @override
  State<DailogWidget> createState() => _DailogWidgetState();
}

class _DailogWidgetState extends State<DailogWidget> {

  TextEditingController quantityController = TextEditingController();
  String seController = '';
  @override
  void initState() {
    super.initState();
    quantityController.text = ''; // Set the text to empty initially
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2, child: Text(widget.dialog_stock[widget.i]!.stockName, style: TextStyle(fontSize: 28),)),
                    // SizedBox(width: 18),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('BSE is selected!');
                                  seController = 'BSE';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 1,
                                    )
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  child: Center(
                                      child: Text('BSE', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w500),)),
                                ),
                              ),
                              SizedBox(width: 8,),
                              InkWell(
                                onTap: () {
                                  print('NSE is selected!');
                                  seController = 'NSE';
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.0),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      )
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  child: Center(
                                      child: Text('NSE', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w500),)),
                                ),
                              ),
                            ],
                          ),
                          Text('${widget.dialog_stock[widget.i]!.rate}', style: TextStyle(fontSize: 18, color: Colors.green),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Quantity', style: TextStyle(fontSize: 22),),
                    SizedBox(width: 16,),
                    Container(
                      width: 170,
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Buying Qty.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        controller: quantityController,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('BUY button pressed');
                        // we will call our add a hold function here
                        print(widget.dialog_stock[widget.i]!.stockName);
                        print('${widget.dialog_stock[widget.i]?.rate}');
                        print(seController);
                        print(int.parse(quantityController.text));

                        if (int.parse(quantityController.text) > 0){
                          addData();
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10), // Button padding
                      ),
                      child: Text('BUY', style: TextStyle(color: Colors.white, fontSize: 22),),
                    ),
                    SizedBox(width: 26), // Add some space between buttons
                    ElevatedButton(
                      onPressed: () {
                        print('EXIT button pressed');
                        Navigator.pop(context);
                        // quantity zero krni h
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10), // Button padding
                      ),
                      child: Text('EXIT', style: TextStyle(color: Colors.white, fontSize: 22),),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // this function adds the selected stock from the watchlist to the holding page
  Future<HoldingModel?> addData() async {
    try {
      final call_API = "http://$wifi/holding";
      var response = await http.post(
        Uri.parse(call_API),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'stock_name': widget.dialog_stock[widget.i]!.stockName,
          'rate': widget.dialog_stock[widget.i]?.rate,
          'se': seController,
          'quantity': int.parse(quantityController.text),
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        // Assuming studentModelFromJson function is correctly defined elsewhere
        String responseString = response.body;
        return holdingModelFromJson(responseString);
      } else {
        print("Check the validator!");
        return null;
      }
    } catch (e) {
      print('Error submitting data: $e');
      return null;
    }
  }

}
