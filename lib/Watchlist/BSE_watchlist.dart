import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/Stockslist/bse.dart';
import 'package:newsapp/controllers/bse_controller.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> n1 = [];
List<String> s1 = [];


class BSEWatchlist extends StatefulWidget {
  const BSEWatchlist({Key? key}) : super(key: key);

  @override
  State<BSEWatchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<BSEWatchlist> {

  BSEcontroller bsecontroller = Get.put(BSEcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bsecontroller.n.isNotEmpty
            ? ListView.builder(
                itemCount: bsecontroller.n.length,
                itemBuilder: (context, position) {
                  return Card(
                    child: ListTile(
                      title: SizedBox(
                        height: 30,
                        width: 90,
                        child: Marquee(
                          text: bsecontroller.n[position] == ''
                              ? '  Name Unavailable  '
                              : "  " + bsecontroller.n[position] + "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: bsecontroller.n[position] == '  Name Unavailable  '
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(right: 120.0),
                          child: Text(
                            bsecontroller.s[position],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      onTap: () {
                        int i;
                        for(i=0; i<m3!.length; i++) {
                          if(m3![i].symbol == bsecontroller.s[position]) {
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
