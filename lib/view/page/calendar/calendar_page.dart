import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/page/calendar/calendar_bar.dart';
import 'package:rafpored/view/page/calendar/calendar_body.dart';

class CalendarPage extends StatelessWidget {

  final Filter _filter = Filter();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            CalendarBar(Res.Strings.appName, _filter),
            CalendarBody(_filter),
          ],
        ),
      );
}