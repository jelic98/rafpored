import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/controller/filter/filter_listener.dart';
import 'package:rafpored/view/common/list/list_item_factory.dart';
import 'package:rafpored/view/common/list/list_widget.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/controller/network/event_fetcher.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

class RefreshListWidget extends ListWidget {

  final _RefreshListWidgetState _state;

  RefreshListWidget(List<dynamic> items, ListItemFactory factory, Filter filter) :
        _state = _RefreshListWidgetState(items, factory, filter), super(items, factory);

  @override
  ListWidgetState createState() => _state;
}

class _RefreshListWidgetState extends ListWidgetState implements FetchListener {

  Filter _filter;
  Widget _content;

  _RefreshListWidgetState(List<dynamic> items, ListItemFactory factory, this._filter)
      : super(items, factory) {
    _filter.listener = FilterListener(this);
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) {
      return Center(
        child: IconButton(
          onPressed: () => _getEvents(),
          icon: Icon(Icons.refresh),
          color: Res.Colors.smallIconDark,
          iconSize: Res.Dimens.bigIconSize,
        ),
      );
    }

    return RefreshIndicator(
      color: Res.Colors.primaryLight,
      onRefresh: _handleRefresh,
      child: _content ?? super.build(context),
    );
  }

  @override
  onEventsFetched(List<dynamic> items, [bool filtered]) {
    if(!mounted) {
      return;
    }

    setState(() {
      super.items = items;
    });

    _filter.extract(items);

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

    EventFetcher.fetchEvents(context, this);
  }

  Future<Null> _handleRefresh() {
    _getEvents();

    Completer<Null> completer = Completer<Null>();
    completer.complete();

    return completer.future;
  }
}