import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/view/common/event_list.dart';
import 'package:rafpored/network/event_fetcher.dart';
import 'package:rafpored/network/on_events_fetched_listener.dart';

class RefreshEventList extends EventList implements OnEventsFetchedListener {

  final OnEventsFetchedListener listener;

  RefreshEventList(List<Event> events, this.listener) : super(events);

  @override
  EventListState createState() => _RefreshEventListState(super.events, this);

  @override
  onEventsFetched(List<Event> events) {
    listener.onEventsFetched(events);
  }
}

class _RefreshEventListState extends EventListState implements OnEventsFetchedListener {

  RefreshEventList list;
  Widget _content;

  _RefreshEventListState(List<Event> events, this.list) : super(events);

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
  onEventsFetched(List<Event> events) {
    setState(() {
      super.events = events;

      list.onEventsFetched(events);

      if(events.isEmpty) {
        _content = Center(
          child: Text(Res.Strings.alertNoItems, style: Res.TextStyles.listPlaceholder),
        );
      }else {
        _content = super.build(context);
      }
    });
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