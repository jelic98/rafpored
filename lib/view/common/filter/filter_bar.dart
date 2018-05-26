import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/controller/filter/filter_button_provider.dart';

class FilterBar extends StatefulWidget {

  final _FilterBarState _state;

  FilterBar(String title, IconButton action, Filter filter) :
        _state = _FilterBarState(title, action, filter);

  @override
  _FilterBarState createState() => _state;
}

class _FilterBarState extends State<FilterBar> {

  final String _title;
  final IconButton _action;

  FilterButtonProvider _provider;
  Widget _filterButton;

  _FilterBarState(this._title, this._action, Filter filter) {
    _provider = FilterButtonProvider(filter, _updateButton);
  }

  @override
  void initState() {
    super.initState();
    _filterButton = _provider.init(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final double statusHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Material(
        elevation: Res.Dimens.barElevation,
        child: Container(
          padding: EdgeInsets.only(top: statusHeight),
          height: statusHeight + Res.Dimens.barHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _action,
              Text(
                _title,
                style: Res.TextStyles.barTitle,
              ),
              _filterButton,
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

  _updateButton(Widget filterButton) {
    setState(() {
      _filterButton = filterButton;
    });
  }
}