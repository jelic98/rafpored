import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:small_calendar/small_calendar.dart';

class CalendarBody extends StatefulWidget {

  @override
  _CalendarBodyState createState() => new _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {

  String _currentMonth;

  SmallCalendarPagerController _smallCalendarPagerController;
  SmallCalendarDataController _smallCalendarDataController;

  @override
  void initState() {
    super.initState();

    DateTime initialMonth = DateTime.now();

    _smallCalendarPagerController = new SmallCalendarPagerController(
      initialMonth: initialMonth,
      minimumMonth: DateTime(initialMonth.year - 1, initialMonth.month),
      maximumMonth: DateTime(initialMonth.year + 1, initialMonth.month),
    );

    _smallCalendarDataController = new SmallCalendarDataController();

    _updateCurrentMonth(initialMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_currentMonth),
        Container(
          color: Colors.grey[200],
          child: new Center(
            child: new Container(
              width: 250.0,
              height: 250.0,
              color: Colors.white,
              child: new SmallCalendarData(
                firstWeekday: DateTime.monday,
                controller: _smallCalendarDataController,
                child: new SmallCalendarStyle(
                  child: new SmallCalendarPager(
                    controller: _smallCalendarPagerController,
                    onMonthChanged: (month) => _updateCurrentMonth(month),
                    pageBuilder:
                        (BuildContext context, DateTime month) {
                      return new SmallCalendar(
                        month: month,
                        onDayTap: (DateTime day) {
                          Scaffold
                              .of(context)
                              .showSnackBar(new SnackBar(
                              content: new Text(
                                "Pressed on:  ${day.year}.${day.month}.${day.day} ",
                              )));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateCurrentMonth(DateTime timestamp) {
    setState(() {
      _currentMonth = "${timestamp.month}.${timestamp.year}";
    });
  }
}