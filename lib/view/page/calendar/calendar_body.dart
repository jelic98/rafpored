import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rafpored/controller/filter/concrete_filter_listener.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:small_calendar/small_calendar.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/view/common/event_list.dart';
import 'package:rafpored/controller/network/event_fetcher.dart';
import 'package:rafpored/controller/network/fetch_listener.dart';

class CalendarBody extends StatefulWidget {

  final _CalendarBodyState _state;

  CalendarBody(Filter filter) : _state = _CalendarBodyState(filter);

  @override
  _CalendarBodyState createState() => _state;
}

class _CalendarBodyState extends State<CalendarBody> implements FetchListener {

  static final String _keyFormat = "dd-MM-yyyy";

  Filter _filter;
  String _currentMonth;
  Map<String, List<Event>> _events;

  SmallCalendarPagerController _calendarController = SmallCalendarPagerController();

  _CalendarBodyState(this._filter) {
    _filter.listener = ConcreteFilterListener(this);
    _events = {};
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
            child: SmallCalendarData(
              firstWeekday: DateTime.monday,
              isTodayCallback: _isTodayCallback,
              hasTick1Callback: _examTickCallback,
              hasTick2Callback: _colloquiumTickCallback,
              hasTick3Callback: _lectureTickCallback,
              controller: SmallCalendarDataController(),
              child: SmallCalendarStyle(
                dayStyle: DayStyle(
                  showTicks: true,
                  todayColor: Res.Colors.calendarToday,
                  tick1Color: Res.Colors.eventExam,
                  tick2Color: Res.Colors.eventColloquium,
                  tick3Color: Res.Colors.eventLecture,
                ),
                weekdayIndicationStyle: WeekdayIndicationStyle(
                  backgroundColor: Res.Colors.calendarHeader,
                ),
                child: SmallCalendarPager(
                  controller: _calendarController,
                  onMonthChanged: (month) => _updateCurrentMonth(month),
                  pageBuilder: (BuildContext context, DateTime month) {
                    return SmallCalendar(
                      month: month,
                      onDayTap: (day) => _showList(day),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  _showList(DateTime date) {
    String key = _getKey(date);

    if(_events.containsKey(key)) {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) => EventList(_events[key]),
      );
    }
  }

  @override
  onEventsFetched(List<Event> events, [bool filtered]) {
    if(!mounted) {
      return;
    }

    _events.clear();

    setState(() => events.forEach((event) {
      String key = _getKey(event.date);

      if(_events.containsKey(key)) {
        _events[key].add(event);
      }else {
        _events[key] = [event];
      }
    }));

    _filter.extract(events);

    if(filtered == null || !filtered) {
      _filter.loadCriteria(FilterCriteria());
    }

    build(context);
  }

  _getEvents() {
    EventFetcher.fetchEvents(this);

    DateTime currentMonth = DateTime.now();

    _calendarController = SmallCalendarPagerController(
      initialMonth: currentMonth,
      minimumMonth: DateTime(currentMonth.year - 1, currentMonth.month),
      maximumMonth: DateTime(currentMonth.year + 1, currentMonth.month),
    );

    _updateCurrentMonth(currentMonth);
  }

  // Calendar methods

  Future<bool> _isTodayCallback(DateTime date) async {
    DateTime now = DateTime.now();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  Future<bool> _examTickCallback(DateTime date) async
  => _checkDateForEvents(date, EventType.exam);

  Future<bool> _colloquiumTickCallback(DateTime date) async
  => _checkDateForEvents(date, EventType.colloquium);

  Future<bool> _lectureTickCallback(DateTime date) async
  => _checkDateForEvents(date, EventType.lecture);

  bool _checkDateForEvents(DateTime date, EventType type) {
    String key = _getKey(date);

    if(_events.containsKey(key)) {
      for(Event event in _events[key]) {
        if(event.type == type) {
          return true;
        }
      }
    }

    return false;
  }

  _updateCurrentMonth(DateTime date) =>
      setState(() => _currentMonth = "${Res.Strings.months[DateFormat("MM").format(date)]} ${DateFormat("yyyy").format(date)}");

  String _getKey(DateTime date) => DateFormat(_keyFormat).format(date);
}