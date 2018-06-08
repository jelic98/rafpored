import 'package:intl/intl.dart';
import 'package:rafpored/controller/filter/filter_listener.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/view/common/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/controller/network/event_fetcher.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

class CalendarBody extends StatefulWidget {

  final _CalendarBodyState _state;

  CalendarBody(Filter filter) : _state = _CalendarBodyState(filter);

  @override
  _CalendarBodyState createState() => _state;
}

class _CalendarBodyState extends State<CalendarBody> implements FetchListener {

  Fetcher _fetcher;
  Filter _filter;
  String _currentMonth;
  Map<String, List<Event>> _events;
  CalendarWidget _calendarWidget;

  _CalendarBodyState(this._filter) {
    _fetcher = EventFetcher();
    _filter.listener = FilterListener(this);
    _calendarWidget = CalendarWidget(_events = {}, _updateMonth);
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  @override
  Widget build(BuildContext context) =>
      Column(
        children: <Widget>[
          Container(height: Res.Dimens.dividerSmall),
          Text(_currentMonth, style: Res.TextStyles.textFullDark),
          Container(height: Res.Dimens.dividerSmall),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: _calendarWidget,
          ),
        ],
      );

  @override
  onFetched(List<dynamic> items, [bool filtered]) {
    if(!mounted) {
      return;
    }

    _events.clear();

    setState(() => items.forEach((item) {
      String key = CalendarWidget.getKey(item.date);

      if(_events.containsKey(key)) {
        _events[key].add(item);
      }else {
        _events[key] = [item];
      }
    }));

    _filter.extract(items);

    if(filtered == null || !filtered) {
      _filter.loadCriteria(FilterCriteria());
    }

    _calendarWidget.updateEvents(_events);
  }

  _getEvents() {
    _fetcher.fetch(context, this);

    _calendarWidget.init();
  }

  _updateMonth(DateTime date) =>
      setState(() => _currentMonth = "${Res.Strings.months[DateFormat("MM").format(date)]} ${DateFormat("yyyy").format(date)}");
}