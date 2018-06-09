import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rafpored/view/common/calendar/src/data/all.dart';
import 'style/day_style.dart';
import 'callbacks.dart';

class CalendarDay extends StatelessWidget {
  CalendarDay({
    @required this.dayData,
    @required this.isExtended,
    @required this.style,
    this.onPressed,
  })  : assert(style != null),
        assert(isExtended != null),
        assert(dayData != null);

  /// [DayData] for this [CalendarDay].
  final DayData dayData;

  final bool isExtended;

  /// Style of [CalendarDay].
  final DayStyle style;

  /// Called whenever user presses on this [CalendarDay].
  final DateCallback onPressed;

  @override
  Widget build(BuildContext context) {
    VoidCallback onTap;
    if (onPressed != null) {
      onTap = () {
        onPressed(dayData.day.toDateTime());
      };
    }

    List<Widget> columnItems = <Widget>[];

    // adds text
    columnItems.add(
      new Expanded(
        flex: 3,
        child: new Container(
          margin: style.marginNumber,
          child: _buildDayNumber(context),
        ),
      ),
    );

    // adds ticks
    if (style.showTicks) {
      // text-tick separation
      columnItems.add(
        new Container(height: style.textTickSeparation),
      );
      // ticks
      columnItems.add(
        new Expanded(
          flex: 1,
          child: new Container(
            margin: style.marginTick,
            child: _buildTicks(),
          ),
        ),
      );
    }

    return new Container(
      margin: style.margin,
      child: new Material(
        color: (style.shadeCallback != null)
            ? style.shadeCallback(dayData.day.toDateTime())
            : Colors.transparent,
        child: new InkWell(
          onTap: onTap,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: columnItems,
          ),
        ),
      ),
    );
  }

  Widget _buildDayNumber(BuildContext context) {
    Color circleColor = Colors.transparent;
    if (dayData.isToday) {
      circleColor = style.todayColor;
    }
    if (dayData.isSelected) {
      circleColor = style.selectedColor;
    }

    return new Container(
      decoration: new BoxDecoration(
        color: circleColor,
        shape: BoxShape.circle,
      ),
      child: new Center(
        child: new ClipRect(
          child: new Text(
            "${dayData.day.day}",
            style: isExtended ? style.extendedDayTextStyle : style.dayTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildTicks() {
    List<Widget> ticks = <Widget>[];

    // tick1
    if (dayData.hasTick1) {
      ticks.add(
        _buildTick(
          color: style.tick1Color,
        ),
      );
    }

    // tick2
    if (dayData.hasTick2) {
      ticks.add(
        _buildTick(
          color: style.tick2Color,
        ),
      );
    }

    // tick3
    if (dayData.hasTick3) {
      ticks.add(
        _buildTick(
          color: style.tick3Color,
        ),
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: ticks,
    );
  }

  Widget _buildTick({
    @required Color color,
  }) {
    return new Expanded(
      child: new Container(
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
