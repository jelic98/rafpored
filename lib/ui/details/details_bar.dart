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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(
            color: Styles.Colors.barIcon,
          ),
          Text(
            _title,
            style: Styles.TextStyles.barTitle,
          ),
          Opacity(
            // I'm here only to center title
            opacity: 0.0,
            child: IconButton(
              onPressed: null,
              icon: Icon(Icons.android),
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
