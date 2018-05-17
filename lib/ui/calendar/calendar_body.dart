import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:small_calendar/small_calendar.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/network.dart';
import 'package:rafroid/model/event.dart';
import 'package:rafroid/ui/common/event_list.dart';

class CalendarBody extends StatefulWidget {

  @override
  _CalendarBodyState createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {

  static final String _dateFormat = "dd-MM-yyyy";

  Map<String, List<Event>> _events = {};

  String _currentMonth;

  SmallCalendarPagerController _calendarController = SmallCalendarPagerController();

  @override
  void initState() {
    super.initState();

    Network.fetchEvents().asStream().forEach((list) {
      for(Event event in list) {
        String key = _getKey(event.dateFrom);

        if(_events.containsKey(key)) {
          _events[key].add(event);
        }else {
          _events[key] = [event];
        }
      }
    });

    DateTime currentMonth = DateTime.now();

    _calendarController = SmallCalendarPagerController(
      initialMonth: currentMonth,
      minimumMonth: DateTime(currentMonth.year - 1, currentMonth.month),
      maximumMonth: DateTime(currentMonth.year + 1, currentMonth.month),
    );

    _updateCurrentMonth(currentMonth);
  }

  @override
  Widget build(BuildContext context) =>
      Column(
        children: <Widget>[
          Container(height: Res.Dimens.dividerSmall),
          Text(_currentMonth, style: Res.TextStyles.textFullDark),
          Container(height: Res.Dimens.dividerSmall),
          Container(
            height: 300.0,
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
      setState(() => _currentMonth = "${DateFormat("MMMM yyyy").format(date)}");

  String _getKey(DateTime date) => DateFormat(_dateFormat).format(date);

  _showList(DateTime date) {
    String key = _getKey(date);

    if(_events.containsKey(key)) {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) => EventList(_events[key]),
      );
    }
  }
}