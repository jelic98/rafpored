import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/controller/filter/filter_listener.dart';
import 'package:rafpored/view/common/list/list_item_factory.dart';
import 'package:rafpored/view/common/list/list_widget.dart';
import 'package:rafpored/controller/filter/filter.dart';
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
    if(_filter != null) {
      _filter.listener = FilterListener(this);
    }
  }

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) {
      return Center(
        child: IconButton(
          onPressed: () => _getItems(),
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
  onFetched(List<dynamic> items, [bool filtered]) {
    if(!mounted) {
      return;
    }

    setState(() {
      super.items = items;
    });

    if(_filter != null) {
      _filter.extract(items);

      if(filtered == null || !filtered) {
        _filter.loadCriteria(FilterCriteria());
      }
    }

    _content = super.build(context);
  }

  _getItems() {
    setState(() {
      _content = Center(
        child: Image(image: AssetImage("assets/img/loading.gif")),
      );
    });

    itemFactory.fetcher.fetch(context, this);
  }

  Future<Null> _handleRefresh() {
    _getItems();

    Completer<Null> completer = Completer<Null>();
    completer.complete();

    return completer.future;
  }
}