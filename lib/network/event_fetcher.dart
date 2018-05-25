import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/network/fetch_listener.dart';

class EventFetcher {

  static fetchEvents(FetchListener listener) {
    _asyncFetch().then((events) => listener.onEventsFetched(events));
  }

  static Future<List<Event>> _asyncFetch() async {
    List<Event> events = List<Event>();

    var response = JsonDecoder().convert((await Http.get(Config.getApiUrl("raspored/json.php"))).body);

    var id = 0;

    for(var event in response) {
      event["id"] = (++id).toString();

      events.add(Event.fromJson(event));
    }

    return events;
  }
}