import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;

class CalendarBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(
        top: MediaQuery
          .of(context)
          .padding
          .top
      ),
      child: new Row(
        children: <Widget>[
          new BackButton(
            color: Theme.Colors.barIcon
          ),
        ],
      ),
    );
  }
}
