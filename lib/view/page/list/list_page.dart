import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/common/filter/filter_bar.dart';
import 'package:rafpored/view/page/list/list_body.dart' as ListBody;

class ListPage extends StatelessWidget {

  final Filter _filter = Filter();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Res.Colors.pageBackground,
      body: Column(
        children: <Widget>[
          FilterBar(
              Res.Strings.appName,
              IconButton(
                onPressed: () => Routes.navigate(context, "/calendar", true),
                icon: Icon(Icons.event),
                color: Res.Colors.barIcon,
              ),
              _filter),
          ListBody.ListBody(_filter),
        ],
      ),
    );
  }
}