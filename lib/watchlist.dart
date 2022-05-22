import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/article2.dart';
import 'package:url_launcher/url_launcher.dart';

List<Article2> a = [];

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: a.isNotEmpty ? ListView.builder(
            itemCount: a.length,
            itemBuilder: (context, position) {
              return Card(
                child: ListTile(
                  title: SizedBox(
                    height: 30,
                    width: 90,
                    child: Marquee(
                      text: a[position].name! == ''
                          ? '  Name Unavailable  '
                          : a[position].name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: a[position].name! == '  Name Unavailable  '
                              ? Colors.red
                              : Colors.black),
                    ),
                  ),
                  leading: Padding(
                      padding: const EdgeInsets.only(right: 120.0),
                      child: Text(
                        a[position].symbol!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  onTap: () {
                    launchUrl(Uri.parse("https://www.marketwatch.com/investing/stock/${a[position].symbol}"));
                  },
                  onLongPress: () {
                    setState(() {
                      a.remove(Article2(
                          name: a[position].name! == ''
                              ? '  Name Unavailable  '
                              : a[position].name!,
                          symbol: a[position].symbol!));
                    });
                  },
                ),
              );
            }) : const Center(child: Text('Watchlist is Empty',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)));
  }
}
