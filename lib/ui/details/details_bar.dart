import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/routes.dart';

class DetailsBar extends StatelessWidget {

  final String _title;

  DetailsBar(this._title);

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
        children: <Widget>[
          BackButton(
            color: Styles.Colors.barIcon,
          ),
          Center(
            child: Text(
              _title,
              style: Styles.TextStyles.barTitle,
            ),
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
