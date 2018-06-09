import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter_listener.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/controller/network/fetcher.dart';
import 'package:rafpored/controller/network/event_fetcher.dart';
import 'package:rafpored/controller/network/period_fetcher.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';
import 'package:rafpored/view/common/calendar_widget.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/period.dart';

class CalendarBody extends StatefulWidget {

  final _CalendarBodyState _state;

  CalendarBody(Filter filter) : _state = _CalendarBodyState(filter);

  @override
  _CalendarBodyState createState() => _state;
}

class _CalendarBodyState extends State<CalendarBody> implements FetchListener {

  Fetcher _eventFetcher;
  Fetcher _periodFetcher;
  Filter _filter;
  String _currentMonth;
  List<Event> _events;
  CalendarWidget _calendarWidget;

  _CalendarBodyState(this._filter) {
    _eventFetcher = EventFetcher();
    _periodFetcher = PeriodFetcher();
    _filter.listener = FilterListener(this);
    _calendarWidget = CalendarWidget(_events = List<Event>(), _updateMonth);
  }

  @override
  void initState() {
    super.initState();

    _periodFetcher.fetch(context, this);

    _updateMonth(DateTime.now());
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

    if(items is List<Period>) {
      _calendarWidget.updatePeriods(items);
      _eventFetcher.fetch(context, this);
      return;
    }

    _events.clear();

    setState(() => items.forEach((item) => _events.add(item)));

    _filter.extract(items);

    if(filtered == null || !filtered) {
      _filter.loadCriteria(FilterCriteria());
    }

    _calendarWidget.updateEvents(_events);
  }

  _updateMonth(DateTime date) =>
      setState(() => _currentMonth = "${Res.Strings.months[DateFormat("MM").format(date)]} ${DateFormat("yyyy").format(date)}");
}