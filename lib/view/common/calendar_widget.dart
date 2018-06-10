import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/config.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/period.dart';
import 'package:rafpored/view/common/calendar/small_calendar.dart';
import 'package:rafpored/view/common/list/list_widget.dart';
import 'package:rafpored/view/page/list/event_item_factory.dart';

class CalendarWidget extends StatefulWidget {

  final _CalendarWidgetState _state;

  CalendarWidget(List<Event> events, Function _monthUpdater) :
        _state = _CalendarWidgetState(events, _monthUpdater);

  @override
  _CalendarWidgetState createState() => _state;

  updateEvents(List<Event> events) {
    _state.updateEvents(events);
  }

  updatePeriods(List<Period> periods) {
    _state.updatePeriods(periods);
  }
}

class _CalendarWidgetState extends State<CalendarWidget> {

  List<Period> _periods;
  List<Event> _events;
  Function _monthUpdater;

  _CalendarWidgetState(this._events, this._monthUpdater);

  @override
  Widget build(BuildContext context) =>
      SmallCalendarData(
        firstWeekday: DateTime.monday,
        isTodayCallback: _isTodayCallback,
        hasTick1Callback: _tickCallback,
        controller: SmallCalendarDataController(),
        child: SmallCalendarStyle(
          dayStyle: DayStyle(
            dayTextStyle: Res.TextStyles.dayNumber,
            extendedDayTextStyle: Res.TextStyles.dayNumberExtended,
            showTicks: true,
            margin: EdgeInsets.all(0.0),
            marginNumber: EdgeInsets.only(top: 5.0),
            marginTick: EdgeInsets.only(bottom: 5.0),
            textTickSeparation: 5.0,
            todayColor: Res.Colors.calendarToday,
            tick1Color: Res.Colors.calendarTick,
            shadeCallback: _dayShade,
          ),
          weekdayIndicationStyle: WeekdayIndicationStyle(
            backgroundColor: Res.Colors.calendarHeader,
          ),
          child:  SmallCalendarPager(
            controller: SmallCalendarPagerController(
              minimumMonth: Config.minDate,
              maximumMonth: Config.maxDate,
            ),
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

  updateEvents(List<Event> events) {
    setState(() {
      _events = events;
    });
  }

  updatePeriods(List<Period> periods) {
    setState(() {
      _periods = periods;
    });
  }

  _showList(DateTime date) {
    List<Event> eventsOnDate = List<Event>();

    for(Event event in _events) {
      if(Event.sameDate(event, date, _periods)) {
        eventsOnDate.add(event);
      }
    }

    if(eventsOnDate.isNotEmpty) {
      showModalBottomSheet<void>(
          context: context,
          builder: (context) => ListWidget(eventsOnDate, EventItemFactory()),
      );
    }
  }

  Future<bool> _isTodayCallback(DateTime date) async {
    DateTime now = DateTime.now();

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  Future<bool> _tickCallback(DateTime date) async {
    for(Event event in _events) {
      if(Event.sameDate(event, date, _periods)) {
        return true;
      }  
    }
    
    return false;
  }

  Color _dayShade(DateTime date) {
    if(_periods == null) {
      return Res.Colors.periodHoliday;
    }

    for(Period period in _periods) {
      if(period.containsDate(date)) {
        return period.type.color;
      }
    }

    return Res.Colors.periodHoliday;
  }
}