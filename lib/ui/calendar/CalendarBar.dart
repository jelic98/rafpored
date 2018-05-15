import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;

class CalendarBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + Theme.Dimens.barHeight,
      child: new Row(
        children: <Widget>[
          new BackButton(
              color: Theme.Colors.barIcon
          ),
        ],
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.Colors.barGradientStart, Theme.Colors.barGradientEnd],
        ),
      ),
    );
  }
}
