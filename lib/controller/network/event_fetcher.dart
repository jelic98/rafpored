import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/utils.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

class EventFetcher {

  static const int _cacheTimeout = 60 * 6; // minutes

  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static List<Event> allEvents;

  static fetchEvents(BuildContext context, FetchListener listener) {
    _checkCache(context, listener);
  }

  static _checkCache(BuildContext context, FetchListener listener) async {
    String lastFetchTime, lastFetchData;

    await _prefs.then((prefs) => lastFetchTime = prefs.getString("lastFetchTime"));
    await _prefs.then((prefs) => lastFetchData = prefs.getString("lastFetchData"));

    DateTime now = DateTime.now();

    if(lastFetchTime != null && lastFetchTime.isNotEmpty &&
        lastFetchData != null && lastFetchData.isNotEmpty) {
      DateTime lastFetch = DateTime.parse(lastFetchTime);

      if(now.difference(lastFetch).inMinutes < _cacheTimeout) {
        _asyncFetch(lastFetchData).then((events) => _onSuccess(events, listener));
        return;
      }
    }

    _hasNetwork().then((ok) =>
    (ok) ? _asyncFetch().then((events)
    => _onSuccess(events, listener)) :
    _onError(context, Res.Strings.alertNoNetwork, listener));

    _prefs.then((prefs) => prefs.setString("lastFetchTime", now.toString()));
  }

  static Future<List<Event>> _asyncFetch([String data]) async {
    List<Event> events = List<Event>();

    var response;

    if(data != null &&  data.isNotEmpty) {
      response = data;
    }else {
      response = (await Http.get(Config.getApiUrl("raspored/json.php"))).body;
    }

    await _prefs.then((prefs) => prefs.setString("lastFetchData", response));

    response = JsonDecoder().convert(response);

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