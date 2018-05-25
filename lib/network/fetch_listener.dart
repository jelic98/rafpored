import 'package:rafpored/model/event.dart';

abstract class FetchListener {

  onEventsFetched(List<Event> events, [bool filtered]);
}