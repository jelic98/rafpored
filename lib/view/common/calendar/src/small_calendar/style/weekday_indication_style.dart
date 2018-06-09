import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Style of weekday indication bar inside a [SmallCalendar].
@immutable
class WeekdayIndicationStyle {
  /// Creates weekday indication style (all values required).
  WeekdayIndicationStyle.raw({
    @required this.weekdayIndicationHeight,
    @required this.textStyle,
    @required this.backgroundColor,
  })  : assert(weekdayIndicationHeight != null),
        assert(textStyle != null),
        assert(backgroundColor != null);

  /// Creates a weekday indication style.
  ///
  /// All null values are set to default values.
  factory WeekdayIndicationStyle({
    double weekdayIndicationHeight = 25.0,
    TextStyle textStyle,
    Color backgroundColor = Colors.blue,
  }) {
    return new WeekdayIndicationStyle.raw(
      weekdayIndicationHeight: weekdayIndicationHeight,
      textStyle: textStyle ?? new TextStyle(),
      backgroundColor: backgroundColor,
    );
  }

  /// Height of weekday indication area.
  final double weekdayIndicationHeight;

  /// [TextStyle] of weekday indication.
  final TextStyle textStyle;

  /// Background [Color] of weekday indication area.
  final Color backgroundColor;

  WeekdayIndicationStyle copyWith({
    double weekdayIndicationHeight,
    TextStyle textStyle,
    Color backgroundColor,
  }) {
    return new WeekdayIndicationStyle.raw(
      weekdayIndicationHeight:
          weekdayIndicationHeight ?? this.weekdayIndicationHeight,
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
