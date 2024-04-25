import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/allstocks.dart';
import '../screens/delete_page.dart';
import '../search.dart';
import 'futurefunctionsforwatchlist.dart';

class watchlist_7 extends StatefulWidget {

  @override
  State<watchlist_7> createState() => _watchlist_7State();
}

class _watchlist_7State extends State<watchlist_7> {

  int page_no = 7;
  List<AllStocksModel?> stocksOfWatchlist_7 = [];

  void reloadList() {
    // function to reload list when we call
    setState(() {
      stocksOfWatchlist_7;
    });
  }

  bool _shouldreload = false;
  void reloadWatchlist_7() {
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
    reloadWatchlist_7();
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
                future: getData(stocksOfWatchlist_7, page_no),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: stocksOfWatchlist_7.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ListTile(
                            // leading: ,
                              title: Text(stocksOfWatchlist_7[index]!.stockName, style: TextStyle(fontSize: 16),),
                              subtitle: Text(stocksOfWatchlist_7[index]!.companyName, style: TextStyle(fontSize: 14),),
                              trailing: Text('${stocksOfWatchlist_7[index]?.rate}', style: TextStyle(fontSize: 18),)
                          ),
                          onTap: () {
                            print(stocksOfWatchlist_7[index]?.stockName);
                            // print(stocksOfWatchlist_7[index]!.id);
                            showDialog(
                              context: context,
                              builder: (context) => DailogWidget(index, stocksOfWatchlist_7),
                            );
                          },
                          onLongPress: () {
                            // goto delete page...
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => deletePage(stocksOfWatchlist_7, page_no)),
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
