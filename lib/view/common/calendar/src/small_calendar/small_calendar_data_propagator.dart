import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rafpored/view/common/calendar/src/data/all.dart';

typedef DayData OnGetDayData(Day day);

/// Widget for propagating dayData down the widget tree.
class SmallCalendarDataPropagator extends InheritedWidget {
  SmallCalendarDataPropagator({
    @required this.firstWeekday,
    @required this.dayNamesMap,
    @required this.dayToDayDataMap,
    @required this.onGetDayData,
    @required Widget child,
  })  : assert(firstWeekday != null),
        assert(dayNamesMap != null),
        assert(dayToDayDataMap != null),
        assert(onGetDayData != null),
        super(child: child);

  final int firstWeekday;

  final Map<int, String> dayNamesMap;

  final Map<Day, DayData> dayToDayDataMap;

  final OnGetDayData onGetDayData;

  /// Returns [DayData] for a specified day.
  DayData getDayData(Day day) => onGetDayData(day);

  @override
  bool updateShouldNotify(SmallCalendarDataPropagator oldWidget) {
    return true;
  }

  static SmallCalendarDataPropagator of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SmallCalendarDataPropagator);
  }
}
