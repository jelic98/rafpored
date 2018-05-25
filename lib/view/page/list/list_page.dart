import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/view/page/list/list_bar.dart';
import 'package:rafpored/view/page/list/list_body.dart' as ListBody;

class ListPage extends StatelessWidget {

  final Filter _filter = Filter();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Res.Colors.pageBackground,
      body: Column(
        children: <Widget>[
          ListBar(Res.Strings.appName, _filter),
          ListBody.ListBody(_filter),
        ],
      ),
    );
  }
}