import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/list/list_bar.dart';
import 'package:rafpored/view/page/list/list_body.dart' as ListBody;

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            ListBar(Res.Strings.app_name),
            ListBody.ListBody(),
          ],
        ),
      );
}