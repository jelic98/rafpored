import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/core/config.dart';

class EventFetcher extends Fetcher {

  static const List<String> endpoints = [
    "exams",
    "classes",
    "consultations",
  ];

  @override
  Future<List<dynamic>> asyncFetch([String data]) async {
    List<Event> items = List<Event>();

    var id = 0;

    for(String endpoint in endpoints) {
      var response;

      if(data != null &&  data.isNotEmpty) {
        response = data;
      }else {
        response = (await Http.get(Config.getApiUrl(endpoint), headers: {"apikey" : Config.apiKey})).body;
      }

      await Fetcher.prefs.then((prefs) => prefs.setString("lastFetchData", response));

      response = JsonDecoder().convert(response)["schedule"];

      for(var event in response) {
        event["id"] = (++id).toString();

        items.add(Event.fromJson(event));
      }
    }

    items.sort((a, b) => sort(a, b));

    return items;
  }

  @override
  int sort(a, b) {
    if(Event.sameDate(a, b)) {
      return a.timeStart.compareTo(b.timeStart);
    }else {
      return a.date.compareTo(b.date);
    }
  }
}