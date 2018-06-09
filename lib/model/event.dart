import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filterable.dart';

class Event implements Filterable {

  static DateFormat _dateFormat = DateFormat("dd.MM");
  static DateFormat _timeFormat = DateFormat("HH:mm");

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
    response = _formatJson(response);

    return Event(
        id: response["id"],
        subject: response["class_name"],
        professor: response["professor"],
        classroom: response["classroom"],
        groups: response["student_groups"].toString().split(", "),
        date: _getDate(response["date"], response["day_of_week"]),
        timeStart: _getTimeStart(response["time"]),
        timeEnd: _getTimeEnd(response["time"]),
        type: _getType(response["type"]),
        notes: _getNotes(response["notes"]),
        repeatsWeekly: _getRepeatsWeekly(_getType(response["type"])),
    );
  }

  static Map<String, dynamic> _formatJson(Map<String, dynamic> response) {
    response["day_of_week"] ??= response["day"];
    response["professor"] ??= response["lecturer"];
    response["class_name"] ??= response["test_name"];
    response["type"] ??= "CONSULTATIONS";
    response["student_groups"] ??= "";

    String dateTime = response["date_and_time"];

    if(dateTime != null && dateTime.isNotEmpty) {
      response["date"] = dateTime.substring(0, dateTime.indexOf("|"));
      response["time"] = dateTime.substring(dateTime.indexOf("|") + 1);
    }

    return response;
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

  String getDate() => "${Res.Strings.days[DateFormat("E").format(date)]} ${_dateFormat.format(date)}";

  String getTimeStart() => _timeFormat.format(timeStart);

  String getTimeEnd() => _timeFormat.format(timeEnd);

  // Helpers

  static EventType _getType(String type) {
    if(type.toString().toUpperCase() == "EXAM") {
      return EventType.exam;
    }

    if(type.toString().toUpperCase() == "CURRICULUM") {
      return EventType.curriculum;
    }

    if(type.toString().toUpperCase() == "CONSULTATIONS") {
      return EventType.consultations;
    }

    return EventType.lecture;
  }

  static bool _getRepeatsWeekly(EventType type) {
    return type == EventType.lecture || type == EventType.consultations;
  }

  static String _getNotes(String notes) {
    return (notes != null && notes.isNotEmpty)
        ? notes : Res.Strings.captionNoNotes;
  }

  static DateTime _getDate(String date, String day) {
    DateTime result;

    if(date != null && date.isNotEmpty) {
      result = _dateFormat.parse(date);

      return DateTime(DateTime.now().year, result.month, result.day);
    }

    result = DateTime.now();

    day = day.toUpperCase().replaceAll("?ET", "ČET").substring(0, 3);

    while(Res.Strings.days[DateFormat("E").format(result)].toUpperCase() != day) {
      result = result.add(Duration(days: 1));
    }

    return result;
  }

  static DateTime _getTimeStart(String time) {
    time = time.substring(0, time.indexOf("-"));
    time += (time.length == 2) ? ":00" : "";

    return _timeFormat.parse(time);
  }

  static DateTime _getTimeEnd(String time) {
    time = time.substring(time.indexOf("-") + 1);
    time += (time.length == 2) ? ":00" : "";

    return _timeFormat.parse(time);
  }

  static bool sameDate(Event a, dynamic b) {
    if(b is Event) {
      return a.getDate() == b.getDate();
    }

    if(a.repeatsWeekly) {
      return DateFormat("E").format(a.date) == DateFormat("E").format(b);
    }

    // todo check periods
    // PeriodType.semester => EventType.lecture & EventType.consultation
    // PeriodType.exams => EventType.exam
    // PeriodType.curriculums => EventType.curriculum
    // PeriodType.holiday => /

    return a.date.year == b.year &&
        a.date.month == b.month &&
        a.date.day == b.day;
  }
}

class EventType {

  final String name;
  final Color color;

  const EventType(this.name, this.color);

  static const EventType exam = const EventType("Ispit", Res.Colors.eventExam);
  static const EventType curriculum = const EventType("Kolokvijum", Res.Colors.eventCurriculum);
  static const EventType lecture = const EventType("Predavanje", Res.Colors.eventLecture);
  static const EventType consultations = const EventType("Konsultacije", Res.Colors.eventConsultations);
}