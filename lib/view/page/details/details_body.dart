import 'package:flutter/material.dart';

class DetailsBody extends StatefulWidget {

  final DetailsBodyState _state;

  DetailsBody(this._state);

  @override
  DetailsBodyState createState() => _state;
}

abstract class DetailsBodyState extends State<DetailsBody> {

  final dynamic item;

  DetailsBodyState(this.item);
}