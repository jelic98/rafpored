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

  _ListBodyState _state;
   EventExtractor _extractor;

  ListBody() {
    _state = _ListBodyState();
  }

  @override
  _ListBodyState createState() => _state;

  @override
  onFilterShown(Filter filter) {
    if(_extractor == null) {
      _extractor = EventExtractor(_state.events);
    }

    filter.eventTypes = _extractor.getEventTypes();
    filter.subjects = _extractor.getSubjects();
    filter.professors = _extractor.getProfessors();
    filter.classrooms = _extractor.getClassrooms();
    filter.groups = _extractor.getGroups();
  }

  @override
  onFiltered(FilterCriteria criteria) {
    List<Event> events = _state.events;

    events.removeWhere((event) =>
        (criteria.eventType != null && event.type != criteria.eventType) ||
        (criteria.subject != null && event.subject != criteria.subject) ||
        (criteria.professor != null && event.professor != criteria.professor) ||
        (criteria.classroom != null && event.classroom != criteria.classroom) ||
        (criteria.group != null && !event.groups.contains(criteria.group)));

    _state.eventList.state.onEventsFetched(events);
  }
}

class _ListBodyState extends State<ListBody> implements OnEventsFetchedListener {

  List<Event> events;
  RefreshEventList eventList;

  @override
  Widget build(BuildContext context) {
    eventList = RefreshEventList(null, this);

    return Flexible(
      child: Container(
        child: eventList,
      ),
    );
  }

  @override
  onEventsFetched(List<Event> events) {
    this.events = events;
  }
}