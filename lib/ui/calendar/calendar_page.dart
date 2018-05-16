import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/ui/calendar/calendar_bar.dart';
import 'package:rafroid/ui/calendar/calendar_body.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            CalendarBar("Rafpored"),
            CalendarBody(),
          ],
        ),
      );
}