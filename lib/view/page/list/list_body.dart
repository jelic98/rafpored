import 'package:flutter/material.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/network/on_events_fetched_listener.dart';
import 'package:rafpored/view/common/event_list.dart';
import 'package:rafpored/view/common/refresh_event_list.dart';
import 'package:rafpored/model/event_extractor.dart';
import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/view/common/filter_listener.dart';

class ListBody extends StatefulWidget implements FilterListener {

  RefreshEventList _eventList;
  EventExtractor _extractor;

  @override
  _ListBodyState createState() => _ListBodyState(_eventList = RefreshEventList(null));

  @override
  onFilterShown(Filter filter) {
    if(_extractor == null) {
      _extractor = EventExtractor(_eventList.events);
    }

    filter.eventTypes = _extractor.getEventTypes();
    filter.subjects = _extractor.getSubjects();
    filter.professors = _extractor.getProfessors();
    filter.classrooms = _extractor.getClassrooms();
    filter.groups = _extractor.getGroups();
  }

  @override
  onFiltered(FilterCriteria criteria) {
    List<Event> events = _eventList.events;

    events.removeWhere((event) =>
        (criteria.eventType != null && event.type != criteria.eventType) ||
        (criteria.subject != null && event.subject != criteria.subject) ||
        (criteria.professor != null && event.professor != criteria.professor) ||
        (criteria.classroom != null && event.classroom != criteria.classroom) ||
        (criteria.group != null && !event.groups.contains(criteria.group)));

    _eventList.onEventsFetched(events);
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