import 'package:flutter/material.dart';
import 'package:rafroid/ui/calendar/CalendarBar.dart';
import 'package:rafroid/ui/calendar/CalendarBody.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new CalendarBar(),
          new CalendarBody(),
        ],
      ),
    );
  }
}