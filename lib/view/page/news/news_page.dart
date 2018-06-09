import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/common/back_bar.dart';
import 'package:rafpored/view/page/news/news_body.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Res.Colors.pageBackground,
        body: Column(
          children: <Widget>[
            BackBar(Res.Strings.appName),
            NewsBody(),
          ],
        ),
      );
}