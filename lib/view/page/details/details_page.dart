import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/details/details_bar.dart';
import 'package:rafpored/view/page/details/details_body.dart';
import 'package:rafpored/model/event.dart';

class DetailsPage extends StatelessWidget {

  final Event _event;

  DetailsPage(this._event);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Column(
          children: <Widget>[
            DetailsBar(Res.Strings.appName),
            DetailsBody(_event),
          ],
        ),
      );
}