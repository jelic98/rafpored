import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;

class Event {

  static const String _dateFormat = "E dd.MM";
  static const String _timeFormat = "HH:mm";

  final String id;
  final String subject;
  final String professor;
  final DateTime date;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String classroom;
  final List<dynamic> groups;
  final EventType type;
  final String notes;
  final bool repeatsWeekly;

  Event({
	  this.id,
	  this.subject,
	  this.professor,
	  this.classroom,
    this.groups,
    this.date,
	  this.timeStart,
    this.timeEnd,
	  this.type,
    this.notes,
    this.repeatsWeekly,
  });

  factory Event.fromJson(Map<String, dynamic> response) {
    Event event =  Event(
        id: response["id"],
        subject: response["predmet"],
        professor: response["nastavnik"],
        classroom: response["ucionica"],
        groups: response["grupe"].toString().split(", "),
        date: _getDate(response["datum"], response["dan"]),
        timeStart: _getTimeStart(response["termin"]),
        timeEnd: _getTimeEnd(response["termin"]),
        type: _getType(response["tip"]),
        notes: _getNotes(response["notes"]),
        repeatsWeekly: _getType(response["tip"]) == EventType.lecture
    );

    return event;
  }

  String getGroups() {
    var buffer = StringBuffer();

    for(int i = 0; i < groups.length; i++) {
      if(i > 0) {
        buffer.write(", ");
      }

      buffer.write(groups[i]);
    }

    return buffer.toString();
  }

  String getDate() => DateFormat(_dateFormat).format(date);

  String getTimeStart() => DateFormat(_timeFormat).format(timeStart);

  String getTimeEnd() => DateFormat(_timeFormat).format(timeStart);

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

  // Factory methods

  static EventType _getType(String type) {
    return (type.toString().toLowerCase() == "ispit") ? EventType.exam
        : (type.toString().toLowerCase() == "kolokvijum") ?
    EventType.colloquium : EventType.lecture;
  }

  static String _getNotes(String notes) {
    return (notes != null && notes.isNotEmpty)
        ? notes : Res.Strings.alertNoNotes;
  }

  static DateTime _getDate(String date, String day) {
    if(date != null && date.isNotEmpty) {
      return DateTime.parse(date);
    }

    Map<String, String> days = {
      "Mon" : "PON",
      "Tue" : "UTO",
      "Wed" : "SRE",
      "Thu" : "CET",
      "Fri" : "PET",
      "Sat" : "SUB",
      "Sun" : "NED",
    };

    day = day.replaceAll("?ET", "CET");

    DateTime today = DateTime.now();

    while(days[DateFormat("E").format(today)] != day) {
      today = today.add(Duration(days: 1));
    }

    return today;
  }

  static DateTime _getTimeStart(String time) {
    return DateFormat("HH:mm").parseStrict(time.substring(0, time.indexOf("-")));
  }

  static DateTime _getTimeEnd(String time) {
    return DateFormat("HH:mm").parseStrict("${time.substring(time.indexOf("-") + 1)}:00");
  }
}

class EventType {

  final String name;

  const EventType(this.name);

  static const EventType exam = const EventType("Ispit");
  static const EventType colloquium = const EventType("Kolokvijum");
  static const EventType lecture = const EventType("Predavanje");
}