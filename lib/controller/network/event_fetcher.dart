import 'dart:async';
import 'dart:convert';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/event.dart';

class EventFetcher extends Fetcher {

  static const List<String> _endpoints = [
    "exams",
    "classes",
    "consultations",
  ];

  @override
  Future<List<dynamic>> asyncFetch() async {
    List<Event> items = List<Event>();

    var id = 0;

    for(String endpoint in _endpoints) {
      var response = JsonDecoder().convert(await getResponse(endpoint))["schedule"];

      for(var event in response) {
        event["id"] = (++id).toString();

        items.add(Event.fromJson(event));
      }
    }

    items.sort((a, b) => sort(a, b));

    return items;
  }

  @override
  int sort(dynamic a, dynamic b) {
    if(Event.sameDate(a, b)) {
      return a.timeStart.compareTo(b.timeStart);
    }else {
      return a.date.compareTo(b.date);
    }
  }
}