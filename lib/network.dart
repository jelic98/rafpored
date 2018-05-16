import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafroid/model/event.dart';

class Network {

  Future<List<Event>> fetchEvents() async {
    List<Event> events = List<Event>();

    var response = JsonDecoder().convert((await Http.get('http://www.ecloga.org/events.json')).body);

  	for(var event in response) {
      events.add(Event.fromJson(event));
    }

  	return events;
  }
}