import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradepro/screens/delete_page.dart';
import '../models/allstocks.dart';
import '../search.dart';
import 'futurefunctionsforwatchlist.dart';

class watchlist_1 extends StatefulWidget {

  @override
  State<watchlist_1> createState() => _watchlist_1State();
}

class _watchlist_1State extends State<watchlist_1> {

  int page_no = 1;
  List<AllStocksModel?> stocksOfWatchlist_1 = [];

  void reloadList() {
    // function to reload list when we call
    setState(() {
      stocksOfWatchlist_1;
    });
  }

  bool _shouldreload = false;
  void reloadWatchlist_1() {
    if (_shouldreload) {
      print('reloading the watchlist 1.....');
      setState(() {
        // this function is created to reload the page
        _shouldreload = false;
      });
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // reload the widget automatically when the state changes
    reloadWatchlist_1();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Column(
            children: [
              // this is the SearchBar to search and add stocks
              TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search & Add",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onTap: () {
                    // onTap : function to call the search page where actual search environment exits
                    // all the functions exits here are same on each watchlist, may be the comments not presented there, for any issue refer comments from this watchlist.dart file
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => search(page_no)),
                    ).then((_) {
                      // use this setState to reload the updated data after adding new stocks
                      setState(() {
                        _shouldreload = true;
                      });
                    });
                    reloadList();
                  }
              ),
              Expanded(
                child: FutureBuilder(
                  future: getData(stocksOfWatchlist_1, page_no),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: stocksOfWatchlist_1.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: ListTile(
                              // leading: ,
                                title: Text(stocksOfWatchlist_1[index]!.stockName, style: TextStyle(fontSize: 16),),
                                subtitle: Text(stocksOfWatchlist_1[index]!.companyName, style: TextStyle(fontSize: 14),),
                                trailing: Text('${stocksOfWatchlist_1[index]?.rate}', style: TextStyle(fontSize: 18),)
                            ),
                            onTap: () {
                              print(stocksOfWatchlist_1[index]?.stockName);
                              showDialog(
                                context: context,
                                builder: (context) => DailogWidget(index, stocksOfWatchlist_1),
                              );
                            },
                            onLongPress: () {
                              // goto delete page...
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => deletePage(stocksOfWatchlist_1, page_no)),
                              ).then((_) {
                                // use this setState to relaod the updated date list after deletion
                                setState(() {
                                  _shouldreload = true;
                                });
                              });
                              reloadList();
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(thickness: 1,);
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
          ),
          Positioned(
            bottom: 10,
            right: 5,
            child: FloatingActionButton(
              onPressed: () {
                print('floating, reload button pressed!');
                // applying a reload function to perform
                updateRate(page_no);
                // Navigator.push(context, CupertinoPageRoute(builder: (context) => deletePage(stocksOfWatchlist_1, page_no)),
                // ).then((_) {
                //   // use this setState to relaod the updated date list after deletion
                //   setState(() {
                //     _shouldreload = true;
                //   });
                // });
                // reloadList();
                // Navigator.pop(context);
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.refresh),
            ),
          )
        ]
      ),
    );
  }

}