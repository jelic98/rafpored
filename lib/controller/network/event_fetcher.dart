import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:http/http.dart' as Http;
import 'package:rafpored/core/utils.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';
import 'dart:io';

class EventFetcher {

  static const cacheTimeout = 60 * 6; // minutes

  static List<Event> allEvents;

  static fetchEvents(BuildContext context, FetchListener listener) {
    _hasNetwork().then((ok) =>
      (ok) ? _asyncFetch().then((events)
          => _onSuccess(events, listener)) :
          _onError(context, Res.Strings.alertNoNetwork, listener));
  }

  static Future<List<Event>> _asyncFetch() async {
    List<Event> events = List<Event>();

    var response = JsonDecoder().convert((await Http.get(Config.getApiUrl("raspored/json.php"))).body);

    var id = 0;

    for(var event in response) {
      event["id"] = (++id).toString();

      events.add(Event.fromJson(event));
    }

    events.sort((a, b) => _sortEvents(a, b));

    return events;
  }

  static Future<bool> _hasNetwork() async {
    try {
      final result = await InternetAddress.lookup("google.com");

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    }on SocketException catch(_) {
      return false;
    }
  }

  static _onSuccess(List<Event> events, FetchListener listener) {
    allEvents = events;
    listener.onEventsFetched(events);
  }

  static _onError(BuildContext context, String message, FetchListener listener) {
    Utils.showMessage(context, message);
    _onSuccess([], listener);
  }

  static int _sortEvents(Event a, Event b) {
    if(Event.sameDate(a, b)) {
      return a.timeStart.compareTo(b.timeStart);
    }else {
      return a.date.compareTo(b.date);
    }
  }
}