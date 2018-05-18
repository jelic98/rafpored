import 'package:flutter/material.dart';
import 'package:rafroid/core/res.dart' as Res;
import 'package:rafroid/view/page/calendar/calendar_bar.dart';
import 'package:rafroid/view/page/calendar/calendar_body.dart';

class CalendarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            CalendarBar(Res.Strings.app_name),
            CalendarBody(),
          ],
        ),
      );
}