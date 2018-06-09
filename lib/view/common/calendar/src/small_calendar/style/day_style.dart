import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Style of a day inside a [SmallCalendar].
@immutable
class DayStyle {
  /// Creates a day style (all values required).
  DayStyle.raw({
    @required this.dayTextStyle,
    @required this.extendedDayTextStyle,
    @required this.shadeCallback,
    @required this.todayColor,
    @required this.selectedColor,
    @required this.showTicks,
    @required this.tick1Color,
    @required this.tick2Color,
    @required this.tick3Color,
    @required this.margin,
    @required this.marginNumber,
    @required this.marginTick,
    @required this.textTickSeparation,
  })  : assert(dayTextStyle != null),
        assert(extendedDayTextStyle != null),
        assert(shadeCallback != null),
        assert(todayColor != null),
        assert(selectedColor != null),
        assert(showTicks != null),
        assert(tick1Color != null),
        assert(tick2Color != null),
        assert(tick3Color != null),
        assert(margin != null),
        assert(marginNumber != null),
        assert(marginTick != null),
        assert(textTickSeparation != null);

  /// Creates a day style.
  ///
  /// All null values are set to default values.
  factory DayStyle({
    TextStyle dayTextStyle,
    TextStyle extendedDayTextStyle,
    Function shadeCallback,
    Color todayColor,
    Color selectedColor,
    bool showTicks = true,
    Color tick1Color,
    Color tick2Color,
    Color tick3Color,
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
    EdgeInsetsGeometry marginNumber = const EdgeInsets.all(0.0),
    EdgeInsetsGeometry marginTick = const EdgeInsets.all(0.0),
    double textTickSeparation = 2.0,
  }) {
    return new DayStyle.raw(
      dayTextStyle: dayTextStyle ?? new TextStyle(),
      extendedDayTextStyle:
          extendedDayTextStyle ?? new TextStyle(fontWeight: FontWeight.w300),
      shadeCallback: shadeCallback,
      todayColor: todayColor ?? Colors.blue[200],
      selectedColor: selectedColor ?? Colors.purple[200],
      showTicks: showTicks,
      tick1Color: tick1Color ?? Colors.red,
      tick2Color: tick2Color ?? Colors.green,
      tick3Color: tick3Color ?? Colors.blue,
      margin: margin,
      marginNumber: marginNumber,
      marginTick: marginTick,
      textTickSeparation: textTickSeparation,
    );
  }

  /// [TextStyle] of a day inside a [SmallCalendar].
  final TextStyle dayTextStyle;

  /// [TextStyle] of a day inside a [SmallCalendar],
  /// that is not a part of the month that a smallCalendar represents.
  final TextStyle extendedDayTextStyle;

  /// Callback for shading [CalendarDay].
  final Function shadeCallback;

  /// [Color] of indication that specific day is today.
  final Color todayColor;

  /// [Color] of indication that specific day is selected.
  final Color selectedColor;

  /// If true ticks will be shown.
  final bool showTicks;

  /// [Color] of tick1.
  final Color tick1Color;

  /// [Color] of tick2.
  final Color tick2Color;

  /// [Color] of tick3.
  final Color tick3Color;

  /// Margin of day widget.
  final EdgeInsetsGeometry margin;

  /// Margin of day number.
  final EdgeInsetsGeometry marginNumber;

  /// Margin of day tick.
  final EdgeInsetsGeometry marginTick;

  /// Height of separation between day of month text and ticks.
  final double textTickSeparation;

  DayStyle copyWith({
    TextStyle dayTextStyle,
    TextStyle extendedDayTextStyle,
    Function shadeCallback,
    Color todayColor,
    Color selectedColor,
    bool showTicks,
    Color tick1Color,
    Color tick2Color,
    Color tick3Color,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry marginNumber,
    EdgeInsetsGeometry marginTick,
    double textTickSeparation,
  }) {
    return new DayStyle.raw(
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      extendedDayTextStyle: extendedDayTextStyle ?? this.extendedDayTextStyle,
      shadeCallback: shadeCallback ?? this.shadeCallback,
      todayColor: todayColor ?? this.todayColor,
      selectedColor: selectedColor ?? this.selectedColor,
      showTicks: showTicks ?? this.showTicks,
      tick1Color: tick1Color ?? this.tick1Color,
      tick2Color: tick2Color ?? this.tick2Color,
      tick3Color: tick3Color ?? this.tick3Color,
      margin: margin ?? this.margin,
      marginNumber: marginNumber ?? this.marginNumber,
      marginTick: marginTick ?? this.marginTick,
      textTickSeparation: textTickSeparation ?? this.textTickSeparation,
    );
  }
}
