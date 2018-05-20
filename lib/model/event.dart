import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;

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

  String _notes;

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
    Event event =  Event(
        id: response["id"],
        subject: response["subject"],
        professor: response["professor"],
        classrooms: response["classrooms"],
        dateFrom: DateTime.parse(response["dateFrom"]),
        dateTo: DateTime.parse(response["dateTo"]),
        type: (response["type"] == "exam") ? EventType.exam
            : (response["type"] == "colloquium") ?
            EventType.colloquium : EventType.lecture
    );

    event.notes = response["notes"];

    return event;
  }

  String get notes => (_notes == null || _notes.trim().isEmpty)
          ? Res.Strings.alert_no_notes : _notes;

  set notes(String notes) => _notes = notes;

  String getClassrooms() {
    var buffer = StringBuffer();

	  for(int i = 0; i < classrooms.length; i++) {
	    if(i > 0) {
        buffer.write(", ");
	    }
	  
	    buffer.write(classrooms[i]);
	  }

	  return buffer.toString();
  }

  Map<String, String> getDateFrom() => {
      "date" : DateFormat(_dateFormat).format(dateFrom),
      "time" : DateFormat(_timeFormat).format(dateFrom)
  };

  Map<String, String> getDateTo() => {
    "date" : DateFormat(_dateFormat).format(dateTo),
    "time" : DateFormat(_timeFormat).format(dateTo)
  };

  Color getColor() {
    switch(type) {
      case EventType.exam:
        return Res.Colors.eventExam;
      case EventType.colloquium:
        return Res.Colors.eventColloquium;
      default:
        return Res.Colors.eventLecture;
    }
  }
}

enum EventType {
  exam, colloquium, lecture
}