import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/Stockslist/Bse.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> n1 = [];
List<String> s1 = [];


class BSEWatchlist extends StatefulWidget {
  const BSEWatchlist({Key? key}) : super(key: key);

  @override
  State<BSEWatchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<BSEWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: n1.isNotEmpty
            ? ListView.builder(
                itemCount: n1.length,
                itemBuilder: (context, position) {
                  return Card(
                    child: ListTile(
                      title: SizedBox(
                        height: 30,
                        width: 90,
                        child: Marquee(
                          text: n1[position] == ''
                              ? '  Name Unavailable  '
                              : "  " + n1[position] + "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: n1[position] == '  Name Unavailable  '
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(right: 120.0),
                          child: Text(
                            s1[position],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      onTap: () {
                        int i;
                        for(i=0; i<m3!.length; i++) {
                          if(m3![i].symbol == s1[position]) {
                            break;
                          }
                        }
                        launchUrl(Uri.parse(
                            "https://www.google.com/finance/quote/${m3![i].no}:BOM"));
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
