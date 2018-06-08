import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/news.dart';
import 'package:rafpored/core/config.dart';

class NewsFetcher extends Fetcher {

  @override
  Future<List<dynamic>> asyncFetch([String data]) async {
    List<News> items = List<News>();

    var response;

    if(data != null &&  data.isNotEmpty) {
      response = data;
    }else {
      response = (await Http.get(Config.getApiUrl("news"), headers: {"apikey" : Config.apiKey})).body;
    }

    await Fetcher.prefs.then((prefs) => prefs.setString("lastFetchData", response));

    response = JsonDecoder().convert(response)["news"];

    var id = 0;

    for(var news in response) {
      news["id"] = (++id).toString();

      items.add(News.fromJson(news));
    }

    items.sort((a, b) => sort(a, b));

    return items;
  }

  @override
  int sort(a, b) {
    return a.date.compareTo(b.date);
  }
}