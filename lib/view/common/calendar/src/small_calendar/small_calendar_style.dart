import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'style/all.dart';

/// Widget that propagates small calendar style information down the tree.
class SmallCalendarStyle extends InheritedWidget {
  /// Creates a new instance of [SmallCalendarStyle] (with all values required).
  SmallCalendarStyle.raw({
    @required this.showWeekdayIndication,
    @required this.weekdayIndicationStyle,
    @required this.dayStyle,
    @required Widget child,
  })  : assert(showWeekdayIndication != null),
        assert(weekdayIndicationStyle != null),
        assert(dayStyle != null),
        super(child: child);

  /// Creates a new instance of [SmallCalendarStyle].
  ///
  /// If [weekdayIndicationStyle] and/or [dayStyle] are null,
  /// they are set to default values.
  factory SmallCalendarStyle({
    bool showWeekdayIndication = true,
    WeekdayIndicationStyle weekdayIndicationStyle,
    DayStyle dayStyle,
    @required Widget child,
  }) {
    weekdayIndicationStyle ??= new WeekdayIndicationStyle();
    dayStyle ??= new DayStyle();

    return new SmallCalendarStyle.raw(
      showWeekdayIndication: showWeekdayIndication,
      weekdayIndicationStyle: weekdayIndicationStyle,
      dayStyle: dayStyle,
      child: child,
    );
  }

  /// If true weekday indication will be shown.
  final bool showWeekdayIndication;

  /// Style of weekday indication.
  final WeekdayIndicationStyle weekdayIndicationStyle;

  /// Style of a day.
  final DayStyle dayStyle;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return showWeekdayIndication != showWeekdayIndication ||
        weekdayIndicationStyle != weekdayIndicationStyle ||
        dayStyle != dayStyle;
  }

  static SmallCalendarStyle of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SmallCalendarStyle);
  }
}
