import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:rafroid/model/Subject.dart';

class Network {

  Future<List<Subject>> fetchSubjects() async {
    List<Subject> subjects = new List<Subject>();

    var response = new JsonDecoder().convert((await Http.get('http://www.ecloga.org/subjects.json')).body);

  	for(var subject in response) {
      subjects.add(new Subject.fromJson(subject));
    }

  	return subjects;
  }
}