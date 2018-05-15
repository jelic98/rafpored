import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:rafroid/Routes.dart';

class CalendarBar extends StatelessWidget {

  final String _title;

  CalendarBar(this._title);

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
          new IconButton(
            onPressed: () => Routes.navigate(context, '/login', true, Transition.exit),
            icon: new Icon(Icons.exit_to_app),
            color: Theme.Colors.barIcon,
          ),
          new Center(
            child: new Text(
              _title,
              style: Theme.TextStyles.barTitle,
            ),
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
