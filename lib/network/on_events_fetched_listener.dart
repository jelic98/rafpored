import 'package:rafroid/model/event.dart';

abstract class OnEventsFetchedListener {

  onEventsFetched(List<Event> events);
}