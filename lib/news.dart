import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/article.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  Map? mapresponse;

  Future<List<Article>> apicall() async {
    List<Article> list = [];
    http.Response response;
    response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d8344f148be2417e837ab60a95d03be9"));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          mapresponse = json.decode(response.body);
          var resp = mapresponse!['articles'] as List;
          list = resp.map((json) => Article.fromJson(json)).toList();
        });
      }
    }
    return list;
  }

  Widget listview(List<Article> news) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text(
                news[position].title != null ? '${news[position].title}' : "No title available",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: SizedBox(
                    child: news[position].urlimage == null
                        ? Image.asset(
                            'assets/images/unavailable.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${news[position].urlimage}',
                            fit: BoxFit.cover,
                          ),
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              onTap: () => {
                launchUrl(Uri.parse(news[position].url!))
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: apicall(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? listview(snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
