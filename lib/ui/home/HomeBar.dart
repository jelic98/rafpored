import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;

class HomeBar extends StatelessWidget {

  final String title;

  HomeBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + Theme.Dimens.barHeight,
      child: new Center(
        child: new Text(
          title,
          style: Theme.TextStyles.barTitle,
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.Colors.barGradientStart, Theme.Colors.barGradientEnd],
        ),
      ),
    );
  }
}
