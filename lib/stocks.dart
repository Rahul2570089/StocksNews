import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:newsapp/watchlist.dart';
import 'package:url_launcher/url_launcher.dart';
import 'article2.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  List? mapresponse;
  TextEditingController c = TextEditingController();
  List<Article2> list = [];
  List<String> l = [];

  Future<List<Article2>> apicall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://iextrading.com/api/1.0/ref-data/symbols"));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          mapresponse = json.decode(response.body);
          var resp = mapresponse as List;
          list = resp.map((json) => Article2.fromJson(json)).toList();
        });
      }
    }
    return list;
  }

  Widget listview(List<Article2> stocks) {
    return ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: SizedBox(
                height: 50,
                width: 90,
                child: Marquee(
                  text: stocks[position].name! == ''
                      ? '  Name Unavailable  '
                      : stocks[position].name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: stocks[position].name! == ''
                          ? Colors.red
                          : Colors.black),
                ),
              ),
              leading: Padding(
                  padding: const EdgeInsets.only(right: 120.0),
                  child: Text(
                    stocks[position].symbol!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
              onTap: () {
                launchUrl(Uri.parse("https://www.marketwatch.com/investing/stock/${stocks[position].symbol}"));
              },
              onLongPress: () {
                if (l.contains(stocks[position].symbol)) {
                  Fluttertoast.showToast(
                      msg: "Already in watchlist",
                      toastLength: Toast.LENGTH_SHORT);
                } else {
                  setState(() {
                    a.add(Article2(
                        name: stocks[position].name! == ''
                            ? '  Name Unavailable  '
                            : stocks[position].name!,
                        symbol: stocks[position].symbol!));
                    l.add(stocks[position].symbol!);
                    
                  });
                  Fluttertoast.showToast(
                      msg: "Added to watchlist",
                      toastLength: Toast.LENGTH_SHORT);
                }
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                onChanged: ((value) => {
                      setState(() {
                        list = list
                            .where((element) => element.name!.contains(value))
                            .toList();
                      })
                    }),
                controller: c,
                decoration: const InputDecoration(
                  hintText: "Enter stock",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              )),
              SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: const Icon(Icons.search),
                  onPressed: () {},
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.6,
          color: Colors.black,
        ),
        Expanded(
          child: FutureBuilder<List<Article2>>(
              future: apicall(),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? listview(snapshot.data!)
                    : const Center(child: CircularProgressIndicator());
              }),
        ),
      ],
    );
  }
}
