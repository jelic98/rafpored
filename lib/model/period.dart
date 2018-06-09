import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';

class Period {

  final String id;
  final DateTime start;
  final DateTime end;
  final PeriodType type;

  Period({
	  this.id,
	  this.start,
    this.end,
    this.type,
  });

  factory Period.fromJson(Map<String, dynamic> response) {
    return Period(
        id: response["id"],
        start: _getDate(response["start_date"]),
        end: _getDate(response["end_date"]),
        type: _getType(response["type"]),
    );
  }

  // Helpers

  static DateTime _getDate(String date) {
    return DateFormat("dd.MM.yyyy.").parse(date);
  }

  static PeriodType _getType(String type) {
    if(type.toString().toUpperCase() == "EXAMS") {
      return PeriodType.exams;
    }

    if(type.toString().toUpperCase() == "CURRICULUMS") {
      return PeriodType.curriculums;
    }

    if(type.toString().toUpperCase() == "SEMESTER") {
      return PeriodType.semester;
    }

    return PeriodType.holiday;
  }

  bool containsDate(DateTime date) {
    return (date.isAfter(start) || date.isAtSameMomentAs(start))
        && (date.isBefore(end) || date.isAtSameMomentAs(end));
  }

  int getDuration() {
    return end.difference(start).inDays;
  }
}

class PeriodType {

  final Color color;
  final List<EventType> eventTypes;

  const PeriodType(this.color, this.eventTypes);

  static const PeriodType exams = const PeriodType(Res.Colors.periodExams, [EventType.exam]);
  static const PeriodType curriculums = const PeriodType(Res.Colors.periodCurriculums, [EventType.curriculum]);
  static const PeriodType semester = const PeriodType(Res.Colors.periodSemester, [EventType.lecture, EventType.consultations]);
  static const PeriodType holiday = const PeriodType(Res.Colors.periodHoliday, []);
}