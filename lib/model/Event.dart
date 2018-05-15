import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;

class Event {

  static const String _dateFormat = "dd.MM";
  static const String _timeFormat = "HH:mm";

  final String id;
  final String subject;
  final String professor;
  final List<dynamic> classrooms;
  final DateTime dateFrom;
  final DateTime dateTo;
  final EventType type;

  Event({
	  this.id,
	  this.subject,
	  this.professor,
	  this.classrooms,
	  this.dateFrom,
    this.dateTo,
	  this.type
  });

  factory Event.fromJson(Map<String, dynamic> response) {
    return new Event(
      id: response["id"],
      subject: response["subject"],
      professor: response["professor"],
      classrooms: response["classrooms"],
      dateFrom: DateTime.parse(response["dateFrom"]),
      dateTo: DateTime.parse(response["dateTo"]),
      type: (response["type"] == "exam") ? EventType.exam : EventType.colloquium
    );
  }

  String getClassrooms() {
    var buffer = new StringBuffer();

	for(int i = 0; i < classrooms.length; i++) {
	  if(i > 0) {
        buffer.write(", ");
	  }
	  
	  buffer.write(classrooms[i]);
	}

	return buffer.toString();
  }

  Map<String, String> getDateFrom() {
	return {
	  "date" : new DateFormat(_dateFormat).format(dateFrom),
	  "time" : new DateFormat(_timeFormat).format(dateFrom)
    };
  }

  Map<String, String> getDateTo() {
	return {
	  "date" : new DateFormat(_dateFormat).format(dateTo),
	  "time" : new DateFormat(_timeFormat).format(dateTo)
    };
  }

  Color getColor() {
	switch(type) {
      case EventType.exam:
  		return Theme.Colors.cardExam;
      case EventType.colloquium:
  		return Theme.Colors.cardColloquium;
	  default:
  		return Theme.Colors.cardDefault;
    }
  }
}

enum EventType {
  exam, colloquium
}
