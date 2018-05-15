import 'package:flutter/material.dart';
import 'package:rafroid/ui/home/HomeBar.dart';
import 'package:rafroid/ui/home/HomeBody.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new HomeBar("Rafpored"),
          new HomeBody(),
        ],
      ),
    );
  }
}