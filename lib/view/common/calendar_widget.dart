import 'dart:async';
import 'package:intl/intl.dart';
import 'package:small_calendar/small_calendar.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/model/event.dart';
import 'package:rafpored/view/common/list/list_widget.dart';
import 'package:rafpored/view/page/list/event_item_factory.dart';

class CalendarWidget extends StatefulWidget {

  static const String _keyFormat = "dd-MM-yyyy";

  final _CalendarWidgetState _state;

  CalendarWidget(Map<String, List<Event>> events, Function _monthUpdater) :
        _state = _CalendarWidgetState(events, _monthUpdater);

  @override
  _CalendarWidgetState createState() => _state;

  init() {
    _state.init();
  }

  updateEvents(Map<String, List<Event>> events) {
    _state.updateEvents(events);
  }

  static String getKey(DateTime date) => DateFormat(_keyFormat).format(date);
}

class _CalendarWidgetState extends State<CalendarWidget> {

  Map<String, List<Event>> _events;
  Function _monthUpdater;

  SmallCalendarPagerController _calendarController = SmallCalendarPagerController();

  _CalendarWidgetState(this._events, this._monthUpdater);

  @override
  Widget build(BuildContext context) =>
      SmallCalendarData(
        firstWeekday: DateTime.monday,
        isTodayCallback: _isTodayCallback,
        hasTick1Callback: _consultationsTickCallback,
        controller: SmallCalendarDataController(),
        child: SmallCalendarStyle(
          dayStyle: DayStyle(
            showTicks: true,
            todayColor: Res.Colors.calendarToday,
            tick1Color: Res.Colors.eventConsultations,
          ),
          weekdayIndicationStyle: WeekdayIndicationStyle(
            backgroundColor: Res.Colors.calendarHeader,
          ),
          child: SmallCalendarPager(
            controller: _calendarController,
            onMonthChanged: (month) => _monthUpdater(month),
            pageBuilder: (BuildContext context, DateTime month) {
              return SmallCalendar(
                month: month,
                onDayTap: (day) => _showList(day),
              );
            },
          ),
        ),
      );

  init() {
    DateTime currentMonth = DateTime.now();

    _calendarController = SmallCalendarPagerController(
      initialMonth: currentMonth,
      minimumMonth: DateTime(currentMonth.year - 1, currentMonth.month),
      maximumMonth: DateTime(currentMonth.year + 1, currentMonth.month),
    );

    _monthUpdater(currentMonth);
  }

  updateEvents(Map<String, List<Event>> events) {
    setState(() {
      _events = events;
    });
  }

  _showList(DateTime date) {
    String key = CalendarWidget.getKey(date);

    if(_events.containsKey(key)) {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) => ListWidget(_events[key], EventItemFactory()),
      );
    }
  }

  Future<bool> _isTodayCallback(DateTime date) async {
    DateTime now = DateTime.now();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  Future<bool> _consultationsTickCallback(DateTime date) async
  => _checkDateForEvents(date, EventType.consultations);

  bool _checkDateForEvents(DateTime date, EventType type) {
    String key = CalendarWidget.getKey(date);

    if(_events.containsKey(key)) {
      for(Event event in _events[key]) {
        if(event.type == type) {
          return true;
        }
      }
    }

    return false;
  }
}