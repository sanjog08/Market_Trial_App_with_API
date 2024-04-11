import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradepro/models/allstocks.dart';
import '../watchlist/futurefunctionsforwatchlist.dart';


// this class represents the detele page when we have to delete any stock from any watchlist
class deletePage extends StatefulWidget {

  int page_No;
  List<AllStocksModel?> stocksOfWatchlist;
  deletePage(this.stocksOfWatchlist, this.page_No);

  @override
  State<deletePage> createState() => _deletePageState(page_No, stocksOfWatchlist );
}

class _deletePageState extends State<deletePage> {

  int page;
  List<AllStocksModel?> watchlistStocks;
  _deletePageState(this.page, this.watchlistStocks);

  void reloadDelete(){
    setState(() {
      watchlistStocks;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      child: Expanded(
        child: FutureBuilder(
          future: getData(watchlistStocks, page),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: watchlistStocks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      // leading: ,
                        title: Text(watchlistStocks[index]!.stockName, style: TextStyle(fontSize: 16),),
                        // trailing: Text('${watchlistStocks[index]?.rate}', style: TextStyle(fontSize: 18),)
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // call delete api function here
                            deleteStock(watchlistStocks[index]!.id, page);
                            reloadDelete();
                            // Navigator.pop(context);
                            // Navigator.push(context, CupertinoPageRoute(builder: (context) => deletePage(watchlistStocks, page)),);
                          },
                        ),
                    )
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
    );
  }
}