import 'package:flutter/material.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/network/on_events_fetched_listener.dart';
import 'package:rafpored/view/common/event_list.dart';
import 'package:rafpored/view/common/refresh_event_list.dart';
import 'package:rafpored/model/event_extractor.dart';
import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/view/common/filter_listener.dart';
import 'package:rafpored/view/page/list/list_bar.dart';

class ListBody extends StatefulWidget implements FilterListener {

  RefreshEventList _eventList;
  EventExtractor _extractor;
  Function _filterVisibility;

  @override
  _ListBodyState createState() {
    _eventList = RefreshEventList(null);

    _eventList.setFilterVisibiility(_filterVisibility);

    return _ListBodyState(_eventList);
  }

  @override
  onFilterShown(Filter filter) {
    if(_extractor == null) {
      _extractor = EventExtractor(_eventList.backupEvents);
    }

    filter.eventTypes = _extractor.getEventTypes();
    filter.subjects = _extractor.getSubjects();
    filter.professors = _extractor.getProfessors();
    filter.classrooms = _extractor.getClassrooms();
    filter.groups = _extractor.getGroups();
  }

  @override
  onFiltered(FilterCriteria criteria) {
    List<Event> events = _eventList.backupEvents;

    events.removeWhere((event) =>
        (criteria.eventType != null && event.type != criteria.eventType) ||
        (criteria.subject != null && event.subject != criteria.subject) ||
        (criteria.professor != null && event.professor != criteria.professor) ||
        (criteria.classroom != null && event.classroom != criteria.classroom) ||
        (criteria.group != null && !event.groups.contains(criteria.group)));

    _eventList.onEventsFetched(events);
  }

  setFilterVisibiility(Function filterVisibility) {
    _filterVisibility = filterVisibility;
  }
}

class _ListBodyState extends State<ListBody> {

  final RefreshEventList _eventList;

  _ListBodyState(this._eventList);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: _eventList,
      ),
    );
  }
}