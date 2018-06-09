import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rafpored/view/common/calendar/src/data/all.dart';

import 'calendar_day.dart';
import 'callbacks.dart';
import 'small_calendar_data_propagator.dart';
import 'small_calendar_style.dart';
import 'weekday_indicator.dart';

/// SmallCalendar widget.
///
/// For this widget to work
/// it must be nested inside [SmallCalendarData] and [SmallCalendarStyle].
class SmallCalendar extends StatelessWidget {
  SmallCalendar({
    @required this.month,
    this.onDayTap,
    this.dayColorCallback,
  });

  /// Month that is represented in this [SmallCalendar].
  final DateTime month;

  /// Called whenever user taps(clicks) on a day.
  final DateCallback onDayTap;

  /// /// Called whenever day needs information about it's color.
  final Function dayColorCallback;

  List<int> _generateWeekdayIndicationDays(BuildContext context) {
    return generateWeekdays(
      SmallCalendarDataPropagator.of(context).firstWeekday,
    );
  }

  List<Day> _generateDaysOfMonth(BuildContext context) {
    return generateDaysOfMonth(
      month,
      SmallCalendarDataPropagator.of(context).firstWeekday,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnItems = <Widget>[];

    if (SmallCalendarStyle.of(context).showWeekdayIndication) {
      columnItems.add(_buildWeekdayIndication(context));
    }

    columnItems.addAll(_buildWeeks(context));

    return new Column(
      children: columnItems,
    );
  }

  Widget _buildWeekdayIndication(BuildContext context) {
    return new Container(
      color:
          SmallCalendarStyle.of(context).weekdayIndicationStyle.backgroundColor,
      height: SmallCalendarStyle
          .of(context)
          .weekdayIndicationStyle
          .weekdayIndicationHeight,
      child: new Row(
        children: _generateWeekdayIndicationDays(context)
            .map<Widget>((weekday) => new Expanded(
                    child: new WeekdayIndicator(
                  text: SmallCalendarDataPropagator
                      .of(context)
                      .dayNamesMap[weekday],
                  weekdayIndicationStyle:
                      SmallCalendarStyle.of(context).weekdayIndicationStyle,
                )))
            .toList(),
      ),
    );
  }

  List<Widget> _buildWeeks(BuildContext context) {
    List<Widget> r = <Widget>[];

    List<Day> daysOfMonth = _generateDaysOfMonth(context);

    for (int i = 0; i < daysOfMonth.length; i += 7) {
      Iterable<Day> daysOfWeek = daysOfMonth.getRange(i, i + 7);
      r.add(
        new Expanded(
          child: _buildWeek(context, daysOfWeek),
        ),
      );
    }

    return r;
  }

  Widget _buildWeek(BuildContext context, Iterable<Day> daysOfWeek) {
    return new Row(
      children: daysOfWeek
          .map((day) => new Expanded(
                child: new CalendarDay(
                  dayData:
                      SmallCalendarDataPropagator.of(context).getDayData(day),
                  isExtended: day.month != month.month,
                  style: SmallCalendarStyle.of(context).dayStyle,
                  onPressed: onDayTap,
                ),
              ))
          .toList(),
    );
  }
}
