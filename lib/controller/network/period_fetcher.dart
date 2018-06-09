import 'dart:async';
import 'dart:convert';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/period.dart';

class PeriodFetcher extends Fetcher {

  static const String _endpoint = "calendar";

  @override
  Future<List<dynamic>> asyncFetch() async {
    List<Period> items = List<Period>();

    var response = JsonDecoder().convert(await getResponse(_endpoint))["schedule"];

    var id = 0;

    for(var period in response) {
      period["id"] = (++id).toString();

      Period p = Period.fromJson(period);

      if(p.getDuration() < Config.maxPeriodDuration) {
        items.add(p);
      }
    }

    items.sort((a, b) => sort(a, b));

    return items;
  }

  @override
  int sort(dynamic a, dynamic b) {
    return a.getDuration().compareTo(b.getDuration());
  }
}