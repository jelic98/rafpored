import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/network/event_fetcher.dart';
import 'package:rafpored/view/common/filter_listener.dart';
import 'package:rafpored/network/fetch_listener.dart';

class ConcreteFilterListener implements FilterListener {

  FetchListener _fetcher;

  ConcreteFilterListener(this._fetcher);

  @override
  onFiltered(FilterCriteria criteria, Function setFilterVisible) {
    List<Event> events = List<Event>();

    EventFetcher.allEvents.forEach((event) => events.add(event));

    events.removeWhere((event) =>
    (criteria.eventType != null && event.type != criteria.eventType) ||
        (criteria.subject != null && event.subject != criteria.subject) ||
        (criteria.professor != null && event.professor != criteria.professor) ||
        (criteria.classroom != null && event.classroom != criteria.classroom) ||
        (criteria.group != null && !event.groups.contains(criteria.group)));

    if(setFilterVisible != null) {
      setFilterVisible(events.isNotEmpty);
    }

    _fetcher.onEventsFetched(events, true);
  }
}