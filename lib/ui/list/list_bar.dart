import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/routes.dart';

class ListBar extends StatelessWidget {

  final String _title;

  ListBar(this._title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + Styles.Dimens.barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => Routes.navigate(context, "/login", true),
            icon: Icon(Icons.lock),
            color: Styles.Colors.barIcon,
          ),
          Text(
            _title,
            style: Styles.TextStyles.barTitle,
          ),
          IconButton(
            onPressed: () => Routes.navigate(context, "/calendar", true),
            icon: Icon(Icons.calendar_today),
            color: Styles.Colors.barIcon,
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Styles.Colors.barGradientStart, Styles.Colors.barGradientEnd],
        ),
      ),
    );
  }
}