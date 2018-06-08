import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;

class DetailsBar extends StatelessWidget {

  final String _title;

  DetailsBar(this._title);

  @override
  Widget build(BuildContext context) {
    final double statusHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Material(
      elevation: Res.Dimens.barElevation,
      child:Container(
        padding: EdgeInsets.only(top: statusHeight),
        height: statusHeight + Res.Dimens.barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BackButton(
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
