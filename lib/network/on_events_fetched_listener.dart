import 'package:rafpored/model/event.dart';

abstract class OnEventsFetchedListener {

  onEventsFetched(List<Event> events);
}