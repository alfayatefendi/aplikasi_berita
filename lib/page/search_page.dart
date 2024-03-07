import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/news.dart';
import '../providers/news_provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Search",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(hintText: "Cari Berita..."),
                      ),
                    ),
                    IconButton(onPressed: () {
                      news.search(searchController.text);
                    }, icon: Icon(Icons.send))
                  ],
                ),
                SizedBox(height: 20),
                news.isDataEmpty
                    ? SizedBox()
                    : news.isLoadingSearch
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              ...news.resSearch!.articles!.map(
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
      );
    });
  }
}
