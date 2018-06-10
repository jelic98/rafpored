import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/common/list/list_item_factory.dart';

class ListWidget extends StatefulWidget {

  final ListWidgetState _state;

  ListWidget(List<dynamic> items, ListItemFactory factory) :
        _state = ListWidgetState(items, factory);

  @override
  ListWidgetState createState() => _state;
}

class ListWidgetState extends State<ListWidget> {

  List<dynamic> items;
  ListItemFactory itemFactory;

  ListWidgetState(List<dynamic> items, this.itemFactory) {
    this.items = items ?? List<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) {
      return Center(
        child: Text(Res.Strings.captionNoItems, style: Res.TextStyles.listPlaceholder),
      );
    }

    if(MediaQuery.of(context).orientation == Orientation.portrait || items.length == 1) {
      return ListView.builder(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding, bottom: Res.Dimens.listPadding),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) => itemFactory.getItem(context, items[index]),
      );
    }else {
      return GridView.count(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding, bottom: Res.Dimens.listPadding),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        children: items.map((item) => itemFactory.getItem(context, item)).toList(),
      );
    }
  }
}