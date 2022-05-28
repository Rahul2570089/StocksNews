import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/Stockslist/Bse.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> n = [];
List<String> s = [];

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: n.isNotEmpty
            ? ListView.builder(
                itemCount: n.length,
                itemBuilder: (context, position) {
                  return Card(
                    child: ListTile(
                      title: SizedBox(
                        height: 30,
                        width: 90,
                        child: Marquee(
                          text: n[position] == ''
                              ? '  Name Unavailable  '
                              : "  " + n[position] + "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: n[position] == '  Name Unavailable  '
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(right: 120.0),
                          child: Text(
                            s[position],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      onTap: () {
                        int i;
                        for(i=0; i<m3!.length; i++) {
                          if(m3![i].symbol == s[position]) {
                            break;
                          }
                        }
                        launchUrl(Uri.parse(
                            "https://www.google.com/finance/quote/${m3![i].symbol}:NSE"));
                      },
                    ),
                  );
                })
            : const Center(
                child: Text(
                'Watchlist is Empty',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )));
  }
}
