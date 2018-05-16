import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/ui/list/list_bar.dart';
import 'package:rafroid/ui/list/list_body.dart' as ListBody;
import 'package:rafroid/model/event.dart';

class ListPage extends StatelessWidget {

  final List<Event> _events;

  ListPage(this._events);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            ListBar("Rafpored"),
            ListBody.ListBody(_events),
          ],
        ),
      );
}