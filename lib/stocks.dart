import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';
import 'package:newsapp/watchlist.dart';
import 'package:url_launcher/url_launcher.dart';
import 'article2.dart';

List<String>? showcolor = List.generate(2000, (index) => 'false');

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  List? mapresponse;
  TextEditingController c = TextEditingController();
  List<Article2> list = [];
  List<Article2> list2 = [];
  bool show = false;

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
                child: Row(
                  children: [
                    Expanded(
                      child: Marquee(
                        text: stocks[position].name! == ''
                            ? '  Name Unavailable  '
                            : "  " + stocks[position].name! + "  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: stocks[position].name! == ''
                                ? Colors.red
                                : Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: showcolor![position] == 'true'
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                      onPressed: showcolor![position] == 'false'
                          ? () async {
                              setState(() {
                                s.add(stocks[position].symbol!);
                                n.add(
                                  stocks[position].name! == ''
                                      ? '  Name Unavailable  '
                                      : '  ' + stocks[position].name! + '  ',
                                );
                                showcolor![position] = 'true';
                              });
                              await UserSimplePreferences.setColor(showcolor!);
                              await UserSimplePreferences.setWatchlistName(n);
                              await UserSimplePreferences.setWatchlistSymbol(s);
                              Fluttertoast.showToast(
                                  msg: "Added to watchlist",
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          : () async {
                              setState(() {
                                int a = n.indexOf(stocks[position].name! == ''
                                      ? '  Name Unavailable  '
                                      : '  ' + stocks[position].name! + '  ');
                                n.removeAt(a);
                                int b = s.indexOf(stocks[position].symbol!);
                                s.removeAt(b);
                                showcolor![position] = 'false';
                              });
                              await UserSimplePreferences.setColor(showcolor!);
                              await UserSimplePreferences.setWatchlistName(n);
                              await UserSimplePreferences.setWatchlistSymbol(s);
                              Fluttertoast.showToast(
                                  msg: "Removed from watchlist",
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                    ),
                  ],
                ),
              ),
              leading: Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: Text(
                    stocks[position].symbol!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              onTap: () {
                launchUrl(Uri.parse(
                    "https://www.marketwatch.com/investing/stock/${stocks[position].symbol}"));
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
          child: TextField(
            onChanged: ((value) => {
                  setState(() {
                    value = value.toUpperCase();
                    list2 = list
                        .where((element) => element.symbol!.contains(value))
                        .toList() + list
                        .where((element) => element.name!.contains(value))
                        .toList();
                    show = true;
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
          ),
        ),
        const Divider(
          thickness: 0.6,
          color: Colors.black,
        ),
        Expanded(
          child: !show
              ? FutureBuilder<List<Article2>>(
                  future: apicall(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? listview(snapshot.data!)
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Colors.black,
                          ));
                  })
              : listview(list2),
        ),
      ],
    );
  }
}
