import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/calendar/calendar_bar.dart';
import 'package:rafpored/view/page/calendar/calendar_body.dart';

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