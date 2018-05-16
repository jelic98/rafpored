import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/ui/list/list_bar.dart';
import 'package:rafroid/ui/list/list_body.dart' as ListBody;

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.Colors.pageBackground,
      body: Column(
        children: <Widget>[
          ListBar("Rafpored"),
          ListBody.ListBody(),
        ],
      ),
    );
  }
}