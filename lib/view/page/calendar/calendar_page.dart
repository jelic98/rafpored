import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/common/filter/filter_bar.dart';
import 'package:rafpored/view/page/calendar/calendar_body.dart';

class CalendarPage extends StatelessWidget {

  final Filter _filter = Filter();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            FilterBar(
                Res.Strings.appName,
                IconButton(
                  onPressed: () => Routes.navigate(context, "/list", true),
                  icon: Icon(Icons.view_list),
                  color: Res.Colors.barIcon,
                ),
                _filter),
            CalendarBody(_filter),
          ],
        ),
      );
}