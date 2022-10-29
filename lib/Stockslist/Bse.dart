import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/Models/article2.dart';
import 'package:newsapp/controllers/bse_controller.dart';
import 'package:url_launcher/url_launcher.dart';

Map<String, String> m1 = {};
List<String> showsymbol1 = [];
List<String> showcolor1 = [];
List<Article2>? m3;

class BSE extends StatefulWidget {
  const BSE({Key? key}) : super(key: key);

  @override
  State<BSE> createState() => _BSEState();
}

class _BSEState extends State<BSE> {

  BSEcontroller bsecontroller = Get.put(BSEcontroller());


  List? mapresponse;
  TextEditingController c = TextEditingController();
  List<Article2> list = [];
  List<Article2> list2 = [];
  bool show = false;
  TabController? tabController;

  Future<List<Article2>> apicall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://rahul2570089.github.io/jsonAPI/BSE_stocks.json"));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          mapresponse = json.decode(response.body);
          var resp = mapresponse as List;
          list = resp.map((json) => Article2.fromJsonn(json)).toList();
          m3 = resp.map((json) =>  Article2.securityno(json)).toList();
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
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          Icons.star,
                          color: bsecontroller.m[stocks[position].symbol!] == 'true'
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        onPressed: (!bsecontroller.n.contains(stocks[position].name) && !bsecontroller.s.contains(stocks[position].symbol))
                            ? () async {
                                setState(() {
                                  bsecontroller.addToWatchlist(stocks, position);
                                });
                                Fluttertoast.showToast(
                                    msg: "Added to watchlist",
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            : () async {
                                setState(() {
                                  bsecontroller.removeFromWatchlist(stocks, position);
                                });
                                Fluttertoast.showToast(
                                    msg: "Removed from watchlist",
                                    toastLength: Toast.LENGTH_SHORT);
                              },
                      ),
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
                    "https://www.google.com/finance/quote/${stocks[position].no}:BOM"));
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