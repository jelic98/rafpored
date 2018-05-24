import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';

class CalendarBar extends StatelessWidget {

  final String _title;

  CalendarBar(this._title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Material(
      elevation: Res.Dimens.barElevation,
      child: Container(
        padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + Res.Dimens.barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Routes.navigate(context, "/list", true),
              icon: Icon(Icons.view_list),
              color: Res.Colors.barIcon,
            ),
            Text(
              _title,
              style: Res.TextStyles.barTitle,
            ),
            Opacity(
              // I'm here only to center the title
              opacity: 0.0,
              child: IconButton(
                onPressed: () => null,
                icon: Icon(Icons.android),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Res.Colors.primaryDark, Res.Colors.primaryLight],
          ),
        ),
      ),
    );
  }
}