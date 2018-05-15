import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafroid/model/Event.dart';

class Network {

  Future<List<Event>> fetchEvents() async {
    List<Event> events = new List<Event>();

    var response = new JsonDecoder().convert((await Http.get('http://www.ecloga.org/events.json')).body);

  	for(var event in response) {
      events.add(new Event.fromJson(event));
    }

  	return events;
  }
}