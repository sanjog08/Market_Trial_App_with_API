import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/allstocks.dart';
import '../screens/delete_page.dart';
import '../search.dart';
import 'futurefunctionsforwatchlist.dart';

class watchlist_3 extends StatefulWidget {

  @override
  State<watchlist_3> createState() => _watchlist_3State();
}

class _watchlist_3State extends State<watchlist_3> {

  int page_no = 3;
  List<AllStocksModel?> stocksOfWatchlist_3 = [];

  void reloadList() {
    // function to reload list when we call
    setState(() {
      stocksOfWatchlist_3;
    });
  }

  bool _shouldreload = false;
  void reloadWatchlist_3() {
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
    reloadWatchlist_3();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Column(
          children: [
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
                future: getData(stocksOfWatchlist_3, page_no),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: stocksOfWatchlist_3.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            // leading: ,
                            title: Text(stocksOfWatchlist_3[index]!.stockName, style: TextStyle(fontSize: 16),),
                            subtitle: Text(stocksOfWatchlist_3[index]!.companyName, style: TextStyle(fontSize: 14),),
                            trailing: Text('${stocksOfWatchlist_3[index]?.rate}', style: TextStyle(fontSize: 18),)
                          ),
                          onTap: () {
                            print(stocksOfWatchlist_3[index]?.stockName);
                            // print(stocksOfWatchlist_3[index]!.id);
                            showDialog(
                              context: context,
                              builder: (context) => DailogWidget(index, stocksOfWatchlist_3),
                            );
                          },
                          onLongPress: () {
                            // goto delete page...
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => deletePage(stocksOfWatchlist_3, page_no)),
                            ).then((_) {
                              // use this setState to reload the updated data after deletion
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
