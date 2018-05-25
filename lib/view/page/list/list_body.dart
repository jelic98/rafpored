import 'package:flutter/material.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/common/refresh_event_list.dart';

class ListBody extends StatefulWidget {

  final _ListBodyState _state;

  ListBody(Filter filter) : _state = _ListBodyState(RefreshEventList(null, filter));

  @override
  _ListBodyState createState() => _state;
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