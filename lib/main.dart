import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newsapp/Stockslist/bse.dart';
import 'package:newsapp/News/news.dart';
import 'package:newsapp/Watchlist/BSE_watchlist.dart';
import 'package:newsapp/controllers/bse_controller.dart';
import 'package:newsapp/controllers/nse_controller.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';
import 'package:newsapp/Stockslist/nse.dart';
import 'package:newsapp/Watchlist/nse_watchlist.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  await UserSimplePreferences.init();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    title: 'StockOps-INDIAN STOCKS AND NEWS',
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedindex = 0;
  static List<Widget> widgetOptions = [
    const Stocks(),
    const News(),
    const Watchlist(),
  ];

  List<String>? l1,l2,l3,l4;
  NSEcontroller nsecontroller = Get.put(NSEcontroller());
  BSEcontroller bsecontroller = Get.put(BSEcontroller());

  @override
  void initState() {
    super.initState();
    l1 = UserSimplePreferences.getSymbol() ?? [];
    l2 = UserSimplePreferences.getColor() ?? [];
    l3 = UserSimplePreferences.getSymbol1() ?? [];
    l4 = UserSimplePreferences.getColor1() ?? [];
    for (int i = 0; i < l1!.length; i++) {
      nsecontroller.m[l1![i]] = l2![i];
    }
    for (int i = 0; i < l3!.length; i++) {
      bsecontroller.m[l3![i]] = l4![i];
    }

    List<String>? es = UserSimplePreferences.getWatchlistName();
    List<String>? es2 = UserSimplePreferences.getWatchlistName1();
    List<String>? es3 = UserSimplePreferences.getWatchlistSymbol();
    List<String>? es4 = UserSimplePreferences.getWatchlistSymbol1();
    var e = es ?? [];
    var e2 = es2 ?? [];
    var e3 = es3 ?? [];
    var e4 = es4 ?? [];
    nsecontroller.n = e.obs;
    bsecontroller.n = e2.obs;
    nsecontroller.s = e3.obs;
    bsecontroller.s = e4.obs;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 233, 233),
        appBar: AppBar(
          title: Text(
            selectedindex == 0
                ? 'Stocks'
                : selectedindex == 1
                    ? 'News'
                    : 'Watchlist',
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: selectedindex==0 || selectedindex==2 ? const TabBar(
              tabs: [
                Tab(child: Text("NSE",style: TextStyle(color: Colors.black),),),
                Tab(child: Text("BSE",style: TextStyle(color: Colors.black),),),
              ],
            ) : null
        ),
        body: selectedindex==1 ? Center(
          child: widgetOptions.elementAt(selectedindex),
        ) : selectedindex==0 ? const TabBarView(children: [
          Stocks(),
          BSE() 
        ]) : const TabBarView(children: [
            Watchlist(),
            BSEWatchlist()
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/stocks.png",
                width: 35,
                height: 35,
              ),
              label: "Stocks",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/news.png",
                  width: 35,
                  height: 35,
                ),
                label: "News",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/watchlist.png",
                  width: 40,
                  height: 40,
                ),
                label: "Watchlist",
                backgroundColor: Colors.white),
          ],
          currentIndex: selectedindex,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            setState(() {
              selectedindex = index;
            });
          },
        ),
      ),
    );
  }
}
