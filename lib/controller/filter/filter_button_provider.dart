import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/view/common/filter/filter_widget.dart';

class FilterButtonProvider {

  Filter _filter;
  Function _buttonUpdater;
  BuildContext _context;

  FilterButtonProvider(this._filter, this._buttonUpdater);

  Widget init(BuildContext context, bool visible) {
    _context = context;

    return _update(visible);
  }

  Widget _update(bool visible) =>
      IconButton(
        onPressed: () => (visible) ? _buildFilters(_context) : _filter.resetCriteria(_context),
        icon: Icon((visible) ? Icons.search : Icons.refresh),
        color: Res.Colors.barIcon,
      );

  _buildFilters(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => FilterWidget(_filter, _updateState),
      );

  _updateState(bool visible) {
    _buttonUpdater(_update(visible));
  }
}