import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/common/filter/filter_widget.dart';

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
  final Filter _filter;

  Widget _filterButton;

  _FilterBarState(this._title, this._action, this._filter) {
    _filter.buttonUpdater = _updateButton;
  }


  @override
  void initState() {
    super.initState();
    _filterButton = _getButton(false);
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
        ),
    );
  }

  _updateButton(bool visible) {
    setState(() {
      _filterButton = _getButton(visible);
    });
  }

  _getButton(bool visible) {
    return IconButton(
      onPressed: () => (visible) ? _buildFilterWidget(context) : _filter.resetCriteria(context),
      icon: Icon((visible) ? Icons.search : Icons.refresh),
      color: Res.Colors.barIcon,
    );
  }

  _buildFilterWidget(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => FilterWidget(_filter),
    );
  }
}