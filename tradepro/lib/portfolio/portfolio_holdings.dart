import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tradepro/models/holding_models.dart';
import '../models/allstocks.dart';


// reloading widget is reaming here, it can be done by didChangeDependencies

class holdings extends StatefulWidget{
  @override
  State<holdings> createState() => _holdingsState();
}

class _holdingsState extends State<holdings> {


  List<HoldingModel?> holding_list = [];
  // double invested = 0.0;

  void reloadHoldingList() {
    setState(() {
      holding_list;
    });
  }

  bool _shouldReload = false;
  void reloadHolding() {
    print('reloading holding list...');
    setState(() {
      // this function is created to reload the page
      _shouldReload = false;
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // reload the widget automatically when the state changes
    reloadHolding();
  }

  Future<List<HoldingModel?>> getData() async {
    try {
      const call_API = "http://$wifi/holdings";
      final response = await http.get(Uri.parse(call_API));
      if (response.statusCode == 200) {
        holding_list.clear();
        invested = 0;
        current = 0;
        var data = jsonDecode(response.body.toString());
        for (Map<String, dynamic> index in data) {
          num? rate = index['rate'];
          num? realRate = index['real_rate'];       //  !.toDouble();
          num? quantity = index['quantity'];        //  !.toDouble();
          if (rate != null && quantity != null) {
            invested += (rate * quantity);
          }
          if (realRate != null && quantity != null) {
            current += (realRate * quantity);
          }
          holding_list.add(HoldingModel.fromJson(index));
        }
        return holding_list;
      } else {
        // If the response status code is not 200, handle it accordingly
        print('Failed to fetch data: ${response.statusCode}');
        return []; // Return an empty list in case of failure
      }
    } catch (e) {
      // Handle any exceptions that occur during the process
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an exception
    }
  }
  // invested and current async function to get data after the holdings loaded
  // once holdings loaded then our invested and current amount get calculated
  double invested = 0.0;
  double _displayInvested = 0.0;
  bool displayInvested = false;
  double current = 0.0;
  double _displayCurrent = 0.0;
  bool displayCurrent = false;
  double pnl = 0.0;
  double _displayPnL = 0.0;
  bool displayPnL = false;
  @override
  void initState() {
    super.initState();
    // load variable at each second to get updated regularly (invested value)
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _displayInvested = invested;
        _displayCurrent = current;
        pnl = current-invested;
        // pnl = -4565;
        _displayPnL = (pnl)/invested*100;
      });
    });
  }

  Color getPnlColor(num x) {
    return x > 0 ? Colors.green : Colors.red;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Container(

            decoration: BoxDecoration(
              // color: Color(0xFFE0E0E0),
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(20.0),
            // height: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Invested', style: TextStyle(fontSize: 16, color: Color(0xFF616161),),),
                    Text('Current', style: TextStyle(fontSize: 16, color: Color(0xFF616161)),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_displayInvested.toStringAsFixed(2), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),),
                    Text(_displayCurrent.toStringAsFixed(2), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: getPnlColor(_displayCurrent-_displayInvested)),),
                  ],
                ),
                SizedBox(height: 10,),
                Divider( thickness: 1,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('P&L', style: TextStyle(fontSize: 16, color: Color(0xFF616161)),),
                    Text('${pnl.toStringAsFixed(2)} (${_displayPnL.toStringAsFixed(2)}%)', style: TextStyle(fontSize: 16, color: getPnlColor(pnl)),),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: holding_list.length,
                  itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(holding_list[index]?.stockName);
                      // call relaod function here
                      reloadHoldingList();
                      showDialog(
                        context: context,
                        builder: (context) => DailogWidgetHolding(index, holding_list),
                      ).then((_) {
                        // this setSate is called for the reloading purpose after the dialog box exits
                        setState(() {
                          _shouldReload = true;
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text('Qty. ', style: TextStyle(fontSize: 13, color: Color(0xFF616161),),),
                                      Text('${holding_list[index]?.quantity}', style: TextStyle(fontSize: 13, color: Colors.grey.shade900,),)
                                    ],
                                  ),
                                  SizedBox(width: 6,),
                                  Row(
                                    children: [
                                      Text('Avg. ', style: TextStyle(fontSize: 13, color: Color(0xFF616161),),),
                                      Text('${holding_list[index]?.rate.toStringAsFixed(2)}', style: TextStyle(fontSize: 13, color: Colors.grey.shade900,),)
                                    ],
                                  ),
                                ],
                              ),
                              Text('${(holding_list[index]!.quantity*(holding_list[index]!.realRate-holding_list[index]!.rate)).toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: getPnlColor(holding_list[index]!.realRate-holding_list[index]!.rate),),),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(holding_list[index]!.stockName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              Text('${(holding_list[index]!.realRate * holding_list[index]!.quantity).toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: getPnlColor(holding_list[index]!.realRate-holding_list[index]!.rate)),),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(holding_list[index]!.se, style: TextStyle(fontSize: 13, color: Color(0xFF757575),),),
                              Row(
                                children: [
                                  Text('LTP.', style: TextStyle(fontSize: 13, color: Color(0XFF757575),),),
                                  Text(' ${holding_list[index]?.realRate} ', style: TextStyle(fontSize: 13, color: Colors.grey.shade900),),
                                  Text('(${(holding_list[index]!.realRate-holding_list[index]!.rate).toStringAsFixed(2)}%)', style: TextStyle(fontSize: 13, color: getPnlColor(holding_list[index]!.realRate-holding_list[index]!.rate)),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                  separatorBuilder: (context, index) {
                    return Divider(height: 6,);
                  },
                );
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),

        ),
      ],
    );
  }


}

// class dailog widget for the holding page
class DailogWidgetHolding extends StatefulWidget {
  int i;
  List<HoldingModel?> dialog_stock = [];
  DailogWidgetHolding(this.i, this.dialog_stock);

  @override
  State<DailogWidgetHolding> createState() => _DailogWidgetHoldingState();
}

class _DailogWidgetHoldingState extends State<DailogWidgetHolding> {

  TextEditingController quantityController = TextEditingController();
  String seController = '';
  @override
  void initState() {
    super.initState();
    quantityController.text = ''; // Set the text to empty initially
  }
  void reloadStock() {
    setState(() {
      widget.dialog_stock;
    });
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
                          int add = widget.dialog_stock[widget.i]!.quantity + int.parse(quantityController.text);
                          updateStockQuantity(widget.dialog_stock[widget.i]!.id, add);
                          // addData();
                          // call reloadHolding function here
                          reloadStock();
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
                        if (int.parse(quantityController.text) > 0 && int.parse(quantityController.text) <= widget.dialog_stock[widget.i]!.quantity){
                          if (int.parse(quantityController.text) == widget.dialog_stock[widget.i]!.quantity){
                            deleteStockFromHolding(widget.dialog_stock[widget.i]!.id);
                          } else {
                           int remaining = widget.dialog_stock[widget.i]!.quantity - int.parse(quantityController.text);
                            updateStockQuantity(widget.dialog_stock[widget.i]!.id, remaining);
                          }
                        }
                        // call reloadHolding function here
                        reloadStock();
                        Navigator.pop(context);
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


  // delete stock from the holding list because user sell all it's equity
  Future<void> deleteStockFromHolding(String id) async {
    final call_API = "http://$wifi/delholding/$id";
    try {
      final response = await http.delete(Uri.parse(call_API));
      if (response.statusCode == 200) {
        print('Stock sold successfully!');
      } else {
        print('Failed to sold stock. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error solding stock: $e');
    }
  }


  // update function
  Future<void> updateStockQuantity(String id, int newQuantity) async {
    try {
      var url = Uri.parse('http://$wifi/sellholding/$id');
      // Define the request body containing the new quantity
      Map<String, dynamic> requestBody = {
        "quantity": newQuantity,
      };
      // Convert the request body to JSON
      String jsonBody = jsonEncode(requestBody);
      // Make a PATCH request
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        // Successfully updated
        print('Quantity of stock updated successfully!');
      } else {
        // Handle other status codes (e.g., 404 if stock not found)
        print('Failed to update stock quantity. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating stock quantity: $error');
    }
  }


  // delete function

}