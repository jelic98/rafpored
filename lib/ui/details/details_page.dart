import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/ui/details/details_bar.dart';
import 'package:rafroid/ui/details/details_body.dart';
import 'package:rafroid/model/event.dart';

class DetailsPage extends StatelessWidget {

  final Event _event;

  DetailsPage(this._event);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: _event.getColor(),
        body: Column(
          children: <Widget>[
            DetailsBar("Rafpored"),
            DetailsBody(_event),
          ],
        ),
      );
}