import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/allstocks.dart';


// whole search page
class search extends StatefulWidget {

  int watchlist;
  search(this.watchlist);

  @override
  State<search> createState() => _searchState(watchlist);
}

class _searchState extends State<search> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  int watchlist_page;
  _searchState(this.watchlist_page);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // gestureDetector onTap parameter for keyboard disable when click on the screen
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 35,),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _search();
                    },
                  ),
                ),
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  _search();
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus){
                    currentFocus.unfocus();
                  }
                },
              ),
              // function call to build results while searching
              _buildSearchResults(),
            ],
          ),
        ),
      ),
    );
  }

  // API call to search for stocks according to the query got typed in the search bar
  void _search() async {
    String query = _searchController.text;
    String call_API = 'http://$wifi/stocks/search?q=$query';
    final response = await http.get(Uri.parse(call_API));
    if (response.statusCode == 200) {
      setState( () {
        _searchResults = json.decode(response.body);
      });
    } else {
      setState(() {
        _searchResults = [];
      });
      print('Failed to load search results');
    }
  }

  // widget to display stocks after query initialised
  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    } else {
      return Expanded(
        child: ListView.separated(itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(left: 15), child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_searchResults[index]['stock_name'], style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500, color: Color(
                                0xFF424242))),
                            Text(_searchResults[index]['company_name'], style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500, color: Color(
                                0xFF424242))),

                          ],
                        ))),
                    Expanded(flex: 1,
                      // icon button to add stock in the respected watchlist
                      child: IconButton(
                        iconSize: 22,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          print(_searchResults[index]['_id']);
                          // function called to add stock in the respective watchlist
                          addToWatchlist(_searchResults[index]['_id'], watchlist_page);
                          // navigate back to the watchlist after the stock added
                          // Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
          itemCount: _searchResults.length,
          separatorBuilder: (context, index) {
            return Divider(height: 6,);
          },
        ),
      );
    }
  }

  // addToWatchlist function calls API to add selected stock in the respected watchlist
  Future<void> addToWatchlist(String id, int page) async {
    try {
      final call_API = 'http://$wifi/watchlist_$page/$id';
      final response = await http.post(
        Uri.parse(call_API),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print('Successfully added to watchlist: $responseBody');
      } else if (response.statusCode == 404) {
        print('Error: Source _id for stock not found');
      } else {
        print('Failed to add to watchlist. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error adding to watchlist: $e');
    }
  }


}