import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/common/filter.dart';

class ListBar extends StatefulWidget {

  final _ListBarState _state;

  ListBar(title, listener) : _state = _ListBarState(title, listener);

  @override
  _ListBarState createState() => _state;

  Function getFilterVisible() {
    return _state.getFilterVisible();
  }
}

class _ListBarState extends State<ListBar> {

  final String _title;
  final Filter _filter;

  Widget _filterButton;

  _ListBarState(this._title, listener) : _filter = Filter(listener);


  @override
  void initState() {
    super.initState();
    _setFilterVisible(false);
  }

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
            _filterButton
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

  _setFilterVisible(bool visible) {
    setState(() {
      _filterButton = Opacity(
        // I'm here only to center the title
        opacity: (visible) ? 1.0 : 0.0,
        child: IconButton(
          onPressed: (visible) ? () => buildFilters(context) : () => null,
          icon: Icon(Icons.search),
          color: Res.Colors.barIcon,
        ),
      );
    });
  }

  buildFilters(BuildContext context) {
    _filter.listener.onFilterShown(_filter);

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => _filter,
    );
  }

  Function getFilterVisible() {
    return _setFilterVisible;
  }
}