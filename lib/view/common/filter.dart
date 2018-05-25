import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/model/event_extractor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/view/common/filter_listener.dart';
import 'package:rafpored/model/filter_criteria.dart';

class Filter {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  FilterListener listener;
  EventExtractor extractor;
  Function setFilterVisible;

  saveCriteria(FilterCriteria criteria) {
    _prefs.then((prefs) => _saveFilters(prefs, criteria));
  }

  loadCriteria(FilterCriteria criteria) {
    _prefs.then((prefs) => criteria = _loadFilters(prefs, criteria));
  }

  resetCriteria(BuildContext context) {
    Navigator.pop(context);

    saveCriteria(FilterCriteria());
  }

  extract(List<Event> events) {
    extractor = EventExtractor(events);
  }

  _saveFilters(SharedPreferences prefs, FilterCriteria criteria) {
    prefs.setString("eventType", criteria.eventType?.name);
    prefs.setString("subject", criteria.subject);
    prefs.setString("professor", criteria.professor);
    prefs.setString("classroom", criteria.classroom);
    prefs.setString("group", criteria.group);

    listener.onFiltered(criteria, setFilterVisible);
  }

  _loadFilters(SharedPreferences prefs, FilterCriteria criteria) {
    String savedType = prefs.getString("eventType");

    for(EventType type in [EventType.lecture, EventType.colloquium, EventType.exam]) {
      if(savedType == type.name) {
        criteria.eventType = type;
        break;
      }
    }

    criteria.subject = prefs.getString("subject") ?? null;
    criteria.professor = prefs.getString("professor") ?? null;
    criteria.classroom = prefs.getString("classroom") ?? null;
    criteria.group = prefs.getString("group") ?? null;

    listener.onFiltered(criteria, setFilterVisible);
  }
}