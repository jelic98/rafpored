import 'package:flutter/material.dart';
import 'package:rafpored/core/config.dart';
import 'package:rafpored/controller/notifier/notifier_page.dart';
import 'package:rafpored/view/common/back_bar.dart';
import 'package:rafpored/view/page/details/details_body.dart';

class DetailsPage extends NotifierPage {

  final DetailsBodyState _state;

  DetailsPage(this._state);

  @override
  NotifierPageState createState() => DetailsPageState(_state);
}

class DetailsPageState extends NotifierPageState {

  final DetailsBodyState _state;

  DetailsPageState(this._state);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Column(
          children: <Widget>[
            BackBar(Config.appName),
            DetailsBody(_state),
          ],
        ),
      );
}