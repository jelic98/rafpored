import 'package:flutter/material.dart';
import 'package:rafpored/view/common/list/refresh_list_widget.dart';
import 'package:rafpored/view/page/news/news_item_factory.dart';

class NewsBody extends StatefulWidget {

  @override
  _NewsBodyState createState() => _NewsBodyState(RefreshListWidget(null, NewsItemFactory(), null));
}

class _NewsBodyState extends State<NewsBody> {

  final RefreshListWidget _list;

  _NewsBodyState(this._list);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: _list,
      ),
    );
  }
}