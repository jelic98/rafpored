import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/ui/details/details_bar.dart';
import 'package:rafroid/ui/details/details_body.dart';
import 'package:rafroid/model/event.dart';

class DetailsPage extends StatelessWidget {

  final List<Event> _events;

  DetailsPage(this._events);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.Colors.pageBackground,
      body: Column(
        children: <Widget>[
          DetailsBar("Rafpored"),
          DetailsBody(_events),
        ],
      ),
    );
  }
}