import 'package:aplikasi_berita/helpers/api.dart';
import 'package:aplikasi_berita/models/top_news_model.dart';
import 'package:flutter/cupertino.dart';
import '../utils/const.dart';

class NewsProvider with ChangeNotifier {
  bool isDataEmpty = true;
  bool isLoading = true;
  bool isLoadingSearch = true;
  TopNewsModel? resNews;
  TopNewsModel? resSearch;
  setLoading(data) {
    isLoading = data;
    notifyListeners();
  }

  getTopNews() async {
    //panggil API get news
    final res = await api("${baseUrl}top-headlines?country=us&apiKey=$apiKey");

    if(res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
    } else {
      resNews = TopNewsModel();
    }
    isLoading = false;
    notifyListeners();
  }
  search(String search) async {
    print(search);
    isDataEmpty = false;
    isLoadingSearch = true;
    notifyListeners();

    final res = await api("${baseUrl}everything?q=$search&sortBy=popularity&apikey=$apiKey");

    if(res.statusCode == 200) {
      resSearch = TopNewsModel.fromJson(res.data);
    } else {
      resSearch = TopNewsModel();
    }
    isLoadingSearch = false;
    notifyListeners();
  }
}
