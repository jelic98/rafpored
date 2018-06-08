import 'package:flutter/material.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/common/list/refresh_list_widget.dart';
import 'package:rafpored/view/page/list/event_item_factory.dart';

class EventsBody extends StatefulWidget {

  final _EventsBodyState _state;

  EventsBody(Filter filter) : _state = _EventsBodyState(RefreshListWidget(null, EventItemFactory(), filter));

  @override
  _EventsBodyState createState() => _state;
}

class _EventsBodyState extends State<EventsBody> {

  final RefreshListWidget _eventList;

  _EventsBodyState(this._eventList);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: _eventList,
      ),
    );
  }
}