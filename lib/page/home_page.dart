import 'package:aplikasi_berita/components/news.dart';
import 'package:aplikasi_berita/page/search_page.dart';
import 'package:aplikasi_berita/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getNews() {
    Provider.of<NewsProvider>(context, listen: false).getTopNews();
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return RefreshIndicator(
        onRefresh: () async {
          news.setLoading(true);
          return await getNews();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Berita Terbaru Saat Ini",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  news.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ...news.resNews!.articles!.map(
                              (e) => News(
                                image: e.urlToImage ?? '',
                                title: e.title ?? '',
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
