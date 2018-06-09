import 'dart:async';
import 'dart:convert';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/news.dart';

class NewsFetcher extends Fetcher {

  static const String _endpoint = "news";

  @override
  Future<List<dynamic>> asyncFetch() async {
    List<News> items = List<News>();

    var response = JsonDecoder().convert(await getResponse(_endpoint))["news"];

    var id = 0;

    for(var news in response) {
      news["id"] = (++id).toString();

      items.add(News.fromJson(news));
    }

    items.sort((a, b) => sort(a, b));

    return items;
  }

  @override
  int sort(dynamic a, dynamic b) {
    return b.date.compareTo(a.date);
  }
}