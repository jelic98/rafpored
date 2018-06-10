import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/config.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/controller/notifier/notifier_page.dart';
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/common/filter/filter_bar.dart';
import 'package:rafpored/view/page/calendar/calendar_body.dart';

class CalendarPage extends NotifierPage {

  @override
  NotifierPageState createState() => CalendarPageState();
}

class CalendarPageState extends NotifierPageState {

  final Filter _filter = Filter();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            FilterBar(
                Config.appName,
                IconButton(
                  onPressed: () => Routes.navigate(context, "/events", true),
                  icon: Icon(Icons.view_list),
                  color: Res.Colors.barIcon,
                ),
                _filter),
            CalendarBody(_filter),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Routes.navigate(context, "/news", false),
          child: Icon(Icons.comment),
          backgroundColor: Res.Colors.primaryDark,
          elevation: Res.Dimens.buttonElevation,
        ),
      );
}