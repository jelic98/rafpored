import 'package:flutter/material.dart';
import 'package:rafpored/view/common/refresh_event_list.dart';

class ListBody extends StatefulWidget {

  @override
  _ListBodyState createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {

  @override
  Widget build(BuildContext context) =>
      Flexible(
        child: Container(
          child: RefreshEventList(null),
        ),
      );
}