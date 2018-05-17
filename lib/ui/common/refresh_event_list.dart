import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/model/event.dart';
import 'package:rafroid/ui/common/event_list.dart';
import 'package:rafroid/network.dart';

class RefreshEventList extends EventList {

  RefreshEventList(List<Event> events) : super(events);

  @override
  EventListState createState() => _RefreshEventListState(super.events);
}

class _RefreshEventListState extends EventListState {

  _RefreshEventListState(List<Event> events) : super(events);

  @override
  Widget build(BuildContext context) =>
      RefreshIndicator(
        color: Res.Colors.primaryLight,
        onRefresh: _handleRefresh,
        child: super.build(context),
      );

  Future<Null> _handleRefresh() {
    Network.fetchEvents().then((events) => _update(events));

    Completer<Null> completer = new Completer<Null>();
    completer.complete();

    return completer.future;
  }

  void _update(List<Event> events) {
    setState(() => super.events = events);
  }
}