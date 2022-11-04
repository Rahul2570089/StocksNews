import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:newsapp/controllers/nse_controller.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> n = [];
List<String> s = [];

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {

  NSEcontroller nsecontroller = Get.put(NSEcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: nsecontroller.n.isNotEmpty
            ? ListView.builder(
                itemCount: nsecontroller.n.length,
                itemBuilder: (context, position) {
                  return Card(
                    child: ListTile(
                      title: Obx(
                        () => SizedBox(
                          height: 30,
                          width: 90,
                          child: Marquee(
                            text: nsecontroller.n[position] == ''
                                ? '  Name Unavailable  '
                                : "  " + nsecontroller.n[position] + "  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: nsecontroller.n[position] == '  Name Unavailable  '
                                    ? Colors.red
                                    : Colors.black),
                          ),
                        ),
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(right: 120.0),
                          child: Text(
                            nsecontroller.s[position],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      onTap: () {
                        launchUrl(Uri.parse(
                            "https://www.google.com/finance/quote/${nsecontroller.s[position]}:NSE"));
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
