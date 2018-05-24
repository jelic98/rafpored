import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/common/filter.dart';

class ListBar extends StatelessWidget {

  final String _title;
  final Filter _filter;

  ListBar(this._title, listener) : _filter = Filter(listener);

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
              onPressed: () => Routes.navigate(context, "/calendar", true),
              icon: Icon(Icons.event),
              color: Res.Colors.barIcon,
            ),
            Text(
              _title,
              style: Res.TextStyles.barTitle,
            ),
            IconButton(
              onPressed: () => buildFilters(context),
              icon: Icon(Icons.search),
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

  buildFilters(BuildContext context) {
    _filter.listener.onFilterShown(_filter);

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => _filter,
    );
  }
}