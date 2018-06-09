import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

class FilterListener {

  FetchListener _fetcher;

  FilterListener(this._fetcher);

  onFiltered(FilterCriteria criteria, Function setFilterVisible) {
    List<Event> events = List<Event>();

    if(Fetcher.allItems != null) {
      Fetcher.allItems.forEach((event) => events.add(event));
    }

    events.removeWhere((event) =>
    (criteria.eventType != null && event.type != criteria.eventType) ||
        (criteria.subject != null && event.subject != criteria.subject) ||
        (criteria.professor != null && event.professor != criteria.professor) ||
        (criteria.classroom != null && event.classroom != criteria.classroom) ||
        (criteria.group != null && !event.groups.contains(criteria.group)));

    if(setFilterVisible != null) {
      setFilterVisible(events.isNotEmpty);
    }

    _fetcher.onFetched(events, true);
  }
}