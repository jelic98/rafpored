import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;

class Event {

  static const String _dateFormat = "dd.MM";
  static const String _timeFormat = "HH:mm";

  static const Map<String, String> _days = {
    "Mon" : "Pon",
    "Tue" : "Uto",
    "Wed" : "Sre",
    "Thu" : "Cet",
    "Fri" : "Pet",
    "Sat" : "Sub",
    "Sun" : "Ned",
  };

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

  String getDate() => "${_days[DateFormat("E").format(date)]} ${DateFormat(_dateFormat).format(date)}";

  String getTimeStart() => DateFormat(_timeFormat).format(timeStart);

  String getTimeEnd() => DateFormat(_timeFormat).format(timeStart);

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

    day = day.replaceAll("?ET", "CET");

    DateTime today = DateTime.now();

    while(_days[DateFormat("E").format(today)].toLowerCase() != day.toLowerCase()) {
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
  final Color color;

  const EventType(this.name, this.color);

  static const EventType exam = const EventType("Ispit", Res.Colors.eventExam);
  static const EventType colloquium = const EventType("Kolokvijum", Res.Colors.eventColloquium);
  static const EventType lecture = const EventType("Predavanje", Res.Colors.eventLecture);
}