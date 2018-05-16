import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/ui/calendar/calendar_bar.dart';
import 'package:rafroid/ui/calendar/calendar_body.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.Colors.pageBackground,
      body: Column(
        children: <Widget>[
          CalendarBar("Rafpored"),
          CalendarBody(),
        ],
      ),
    );
  }
}