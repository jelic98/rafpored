import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
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

    return Material(
      elevation: Res.Dimens.barElevation,
      child:Container(
        padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + Res.Dimens.barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => Routes.navigate(context, "/login", true),
              icon: Icon(Icons.lock),
              color: Res.Colors.barIcon,
            ),
            Text(
              _title,
              style: Res.TextStyles.barTitle,
            ),
            IconButton(
              onPressed: () => Routes.navigate(context, "/calendar", true),
              icon: Icon(Icons.calendar_today),
              color: Res.Colors.barIcon,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Res.Colors.primaryDark, Res.Colors.primaryLight],
          ),
        ),
      )
    );
  }
}