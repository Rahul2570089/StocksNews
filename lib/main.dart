import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/news.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';
import 'package:newsapp/stocks.dart';
import 'package:newsapp/watchlist.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
       statusBarColor: Colors.transparent,
       statusBarBrightness: Brightness.light
     )
   );
   await UserSimplePreferences.init();
  runApp(const MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,title: 'StockOps',));
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

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

  List<String> ss = List.generate(2000, (index) => 'false');

  @override
  void initState() {
    showcolor = UserSimplePreferences.getColor() ?? ss;
    n = UserSimplePreferences.getWatchlistName() ?? [];
    s = UserSimplePreferences.getWatchlistSymbol() ?? [];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 233, 233),
      appBar: AppBar(
        title: Text(selectedindex==0 ? 'Stocks' : selectedindex==1 ? 'News' : 'Watchlist',style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Image.asset("assets/images/stocks.png",width: 35,height: 35,), label: "Stocks", backgroundColor: Colors.white,),
          BottomNavigationBarItem(icon: Image.asset("assets/images/news.png",width: 35,height: 35,), label: "News", backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Image.asset("assets/images/watchlist.png",width: 40,height: 40,), label: "Watchlist", backgroundColor: Colors.white),
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
    );
  }
}