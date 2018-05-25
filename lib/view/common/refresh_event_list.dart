import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/view/common/concrete_filter_listener.dart';
import 'package:rafpored/view/common/event_list.dart';
import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/view/common/filter_listener.dart';
import 'package:rafpored/network/event_fetcher.dart';
import 'package:rafpored/network/fetch_listener.dart';

class RefreshEventList extends EventList {

  final _RefreshEventListState _state;

  RefreshEventList(List<Event> events, Filter filter) :
        _state = _RefreshEventListState(events, filter), super(events);

  @override
  EventListState createState() {
    return _state;
  }
}

class _RefreshEventListState extends EventListState implements FetchListener {

  Filter _filter;
  Widget _content;

  _RefreshEventListState(List<Event> events, this._filter) : super(events) {
    _filter.listener = ConcreteFilterListener(this);
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) =>
      RefreshIndicator(
        color: Res.Colors.primaryLight,
        onRefresh: _handleRefresh,
        child: _content ?? super.build(context),
      );

  @override
  onEventsFetched(List<Event> events, [bool filtered]) {
    if(!mounted) {
      return;
    }

    setState(() {
      super.events = events;
    });

    _filter.extract(events);

    if(filtered == null || !filtered) {
      _filter.loadCriteria(FilterCriteria());
    }

    _content = super.build(context);
  }

  _getEvents() {
    setState(() {
      _content = Center(
        child: Image(image: AssetImage("assets/img/loading.gif")),
      );
    });

    EventFetcher.fetchEvents(this);
  }

  Future<Null> _handleRefresh() {
    _getEvents();

    Completer<Null> completer = Completer<Null>();
    completer.complete();

    return completer.future;
  }
}