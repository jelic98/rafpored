import 'package:flutter/material.dart';
import 'package:rafroid/core/res.dart' as Res;
import 'package:rafroid/view/page/details/details_bar.dart';
import 'package:rafroid/view/page/details/details_body.dart';
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
            DetailsBar(Res.Strings.app_name),
            DetailsBody(_event),
          ],
        ),
      );
}