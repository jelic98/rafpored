import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/network/fetch_listener.dart';

class EventFetcher {

  static List<Event> allEvents;

  static fetchEvents(FetchListener listener) {
    _asyncFetch().then((events) => _onSuccess(events, listener));
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

  static _onSuccess(List<Event> events, FetchListener listener) {
    allEvents = events;
    listener.onEventsFetched(events);
  }

  static int _sortEvents(Event a, Event b) {
    if(Event.sameDate(a, b)) {
      return a.timeStart.compareTo(b.timeStart);
    }else {
      return a.date.compareTo(b.date);
    }
  }
}